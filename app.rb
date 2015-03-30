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
  helper = MongoHelper.new
  words = params[:words]
  helper.execute_mr(words)
  haml :index
end

get '/queries' do
  @queries = session[:queries]
  haml :queries
end

get '/queries/:token' do
  params[:token]
end
