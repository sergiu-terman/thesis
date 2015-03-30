require 'mongoid'

class ExecutedQuery
  include Mongoid::Document
  store_in collection: "executed_queries"

  field :query_token,     :type => String
  field :words,           :type => String
end
