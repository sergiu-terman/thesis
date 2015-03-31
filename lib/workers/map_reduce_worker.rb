require_relative '../../env'

class MapReduceWorker
  include Sidekiq::Worker

  def perform(words, token)
    MongoHelper.new.execute_mr(words, token)
  end
end