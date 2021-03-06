require_relative '../../env'

class MongoHelper

  def execute_mr(input, token)
    #token = SecureRandom.urlsafe_base64(nil, false)
    clean_input = sanitize_input(input)
    output = ParsedPage.map_reduce(map(clean_input), reduce).out(inline: true)
    result = output.to_a.map do |e|
      {date: e["_id"], mentions: e["value"]}
    end
    ExecutedQuery.where(token: token, words: input).create!
    QueryResult.where(token: token, result: result).create!
  end

  def get_executed_queries
    ExecutedQuery.all.to_a.reverse
  end

  def get_frequency(token)
    QueryResult.where(token: token).first.result.map
  end

  def frequency(input, token)
    result = FrequencyReady.where(word: input).map do |e|
      {
        word: e.word,
        source: e.source,
        year: e.year,
        month: e.month,
        mentions: e.mentions
      }
    end
    ExecutedQuery.where(token: token, words: input).create!
    QueryResult.where(token: token, result: result).create!
  end

private
  def sanitize_input(input)
    splitted_input = input.split(" ")
    splitted_input.map { |word| word.delete ".," }
  end
end