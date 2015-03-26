require_relative 'parsed_page'
require_relative 'mr_methods'

class MRHelper
  def execute_mr(words)
    ParsedPage.map_reduce(map(words), reduce).out(replace: "reduce").first
  end
end