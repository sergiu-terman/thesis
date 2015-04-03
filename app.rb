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
    response.shift
    @result = response.to_json
    haml :plot
  end

  get '/plot' do
    haml :plot
  end
end

