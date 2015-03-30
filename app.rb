require 'rubygems'
require 'sinatra'
require_relative 'lib/mongo/mongo_helper'

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
  helper = MongoHelper.new.execute_mr(params[:words])
  haml :index
end

get '/queries' do
  @queries = MongoHelper.new.get_executed_queries
  p @queries
  haml :queries
end

get '/queries/:token' do
  MongoHelper.new.get_query(params[:token]).to_s
end
