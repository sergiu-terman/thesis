require 'sidekiq'

class MapReduceWorker
  include Sidekiq::Worker

  def perform(name, count)
    p "Perform something"
  end
end