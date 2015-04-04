require 'sinatra/base'
require_relative 'env'

class MyApp < Sinatra::Base
  configure do
    enable :sessions
  end

  helpers do
  end

  before '/*' do
    p "I'm a filter motherfucker"
  end

  get '/' do
    haml :index
  end

  post '/search' do
    token = SecureRandom.urlsafe_base64(nil, false)
    MapReduceWorker.perform_async(params[:words], token)
    token
  end

  get '/queries' do
    @queries = MongoHelper.new.get_executed_queries
    haml :queries
  end

  get '/queries/:token' do
    response = MongoHelper.new.get_query(params[:token])
    @result = sanitize_data(response)
    p @result
    @result = @result.to_json
    haml :plot
  end

  get '/plot' do
    haml :plot
  end

  def sanitize_data(data)
    oldest = Date.parse(data.min_by {|x| x["date"]}["date"].strftime("%Y/%m/%d"))
    newest = Date.parse(data.max_by {|x| x["date"]}["date"].strftime("%Y/%m/%d"))
    all_dates = (oldest..newest).map {|x| x.year.to_s + "-" + x.month.to_s}.uniq

    morphed = {}
    data = data.each do |x|
      date = x["date"].year.to_s + "-" + x["date"].month.to_s
      morphed[date] = morphed.fetch(date, 0) + x["mentions"]
    end
    all_dates.map {|d| {date: d, mentions: morphed.fetch(d, 0)}}
  end
end

