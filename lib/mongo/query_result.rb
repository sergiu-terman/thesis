require_relative '../../env'

class QueryResult
  include Mongoid::Document
  store_in collection: "query_results"

  field :token,   :type => String
  field :result,  :type => Array
end
