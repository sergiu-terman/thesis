require 'sinatra'
require_relative 'env'

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
