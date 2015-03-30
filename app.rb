require 'rubygems'
require 'sinatra'
require 'securerandom'
require_relative 'lib/mr_helper'

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
  helper = MRHelper.new
  query_token = SecureRandom.urlsafe_base64(nil, false)
  words = params[:words]
  helper.execute_mr(words, query_token)
  save_query_session(words, query_token)
  haml :index
end

get '/queries' do
  @queries = session[:queries]
  haml :queries
end

def save_query_session(words, query_token)
  unless session.has_key?(:queries)
    session[:queries] = {}
  end
  session[:queries][query_token] = words
end
