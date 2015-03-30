require_relative 'parsed_page'
require_relative 'query_result'
require_relative 'mr_methods'
require 'mongoid'

class MRHelper

  def initialize
    Mongoid.load!("lib/mongoid.yml", :development)
  end

  def execute_mr(input, query_token)
    clean_input = sanitize_input(input)
    output = ParsedPage.map_reduce(map(clean_input), reduce).out(inline: true)
    result = output.to_a.map do |e|
      {date: e["_id"], mentions: e["value"]}
    end
    QueryResult.where(query_token: query_token, result: result).create!
  end

private
  def sanitize_input(input)
    splitted_input = input.split(" ")
    splitted_input.map { |word| word.delete ".," }
  end
end