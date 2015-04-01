require 'sidekiq'
require 'securerandom'
require 'mongoid'
require 'em-websocket'
require 'tilt/haml'
require 'websocket-eventmachine-client'
require 'json'
require 'redis'
require 'faye'

require_relative "lib/mongo/executed_query"
require_relative "lib/mongo/mongo_helper"
require_relative "lib/mongo/mr_methods"
require_relative "lib/mongo/parsed_page"
require_relative "lib/mongo/query_result"

require_relative "lib/workers/map_reduce_worker"

Mongoid.load!("lib/mongo/mongoid.yml", :development)