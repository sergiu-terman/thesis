require_relative '../../env'

class MapReduceWorker
  include Sidekiq::Worker

  def perform(words, token)
    MongoHelper.new.execute_mr(words, token)
    message = { channel: "/messages/#{token}", data: {message: "#{words} request was analyzed", type: "success"}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end