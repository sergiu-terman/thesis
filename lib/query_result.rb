require 'mongoid'

class QueryResult
  include Mongoid::Document
  store_in collection: "query_results"

  field :query_token,     :type => String
  field :result,          :type => Array
end