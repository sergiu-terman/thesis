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
    MapReduceWorker.perform_async(params[:words])
    haml :index
  end

  get '/queries' do
    @queries = MongoHelper.new.get_executed_queries
    haml :queries
  end

  get '/queries/:token' do
    MongoHelper.new.get_query(params[:token]).to_s
  end
end

