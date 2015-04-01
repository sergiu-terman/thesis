require_relative '../../env'

class NotificationWebsocketClient
  def notify(token, message)
    EM.run do
      ws = WebSocket::EventMachine::Client.connect(:uri => "ws://localhost:8080/#{token}")

      ws.onopen do
        ws.send "Hello pupsic"
      end

      ws.onmessage do |msg, type|
        p "Received message: #{msg}"
      end

      ws.onclose do |code, reason|
        p "Disconnected with status code: #{code}"
        EM::stop_event_loop
      end
    end
  end
end
