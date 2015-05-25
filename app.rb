require 'sinatra/base'


require_relative 'env'

class MyApp < Sinatra::Base
  configure do
    enable :sessions
  end

  helpers do
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
    response = MongoHelper.new.get_frequency(params[:token])
    @result = prepare_data(response)
    haml :plot
  end

  get '/plot' do
    haml :plot
  end

  ##############################################################################
  def prepare_data(data)
    result = { aggregated: aggregate(data), separated: separate(data), original: data }.to_json
  end

  def separate(data)
    result = {}
    result.default = {}
    data.each do |e|
      result[e["source"]] = result[e["source"]].merge(extract_date(e) => e["mentions"])
    end
    f = {}
    dates = date_range(data)
    result.each do |key, value|
      f[key] = dates.map { |d| {date: d, mentions: value.fetch(d, 0)} }
    end
    f
  end

  def aggregate(data)
    result = {}
    data.each do |e|
      date = extract_date(e)
      result[date] = result.fetch(date, 0) + e["mentions"]
    end
    date_range(data).map { |d| {date: d, mentions: result.fetch(d, 0)} }
  end

  def date_range(data)
    oldest = extract_date(data.min_by { |e| extract_date(e) })
    newest = extract_date(data.max_by { |e| extract_date(e) })
    all_dates = (oldest..newest).map { |x| Date.new(x.year, x.month) }.uniq
  end

  def extract_date(e)
    Date.new(e["year"], e["month"])
  end
end

