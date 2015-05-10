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
    @result = @result.to_json
    haml :plot
  end

  get '/plot' do
    haml :plot
  end

  def sanitize_data(data)
    all_dates = gen_date_range(data)
    morphed = {}
    data.each do |e|
      date = e["date"]
      morphed[date] = morphed.fetch(date, 0) + e["mentions"]
    end
    all_dates.map {|d| {date: Date.parse("1-"+d), mentions: morphed.fetch(d, 0)}}
  end

  def gen_date_range(data)
    oldest = extract_date(data.min_by { |e| extract_date(e) })
    newest = extract_date(data.max_by { |e| extract_date(e) })
    all_dates = (oldest..newest).map {|x| x.month.to_s + "-" + x.year.to_s}.uniq
  end

  def extract_date(e)
    Date.parse("1-"+e["date"])
  end
end

