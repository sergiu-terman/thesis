require_relative '../../env'

class MapReduceWorker
  include Sidekiq::Worker

  def perform(words, token)
    message = {channel: "/messages/#{token}", data: {message: "#{words} request was analyzed", type: "success"}}
    begin
      MongoHelper.new.execute_mr(words, token)
    rescue => e
      message[:data] = {message: "An error occurred while trying to analyze: #{words}", type: "danger"}
    end
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end