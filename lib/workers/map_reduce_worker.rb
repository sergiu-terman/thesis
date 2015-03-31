require_relative '../../env'

class MapReduceWorker
  include Sidekiq::Worker

  def perform(words)
    MongoHelper.new.execute_mr(words)
  end
end