require_relative '../../env'

EM.run do
  EM::WebSocket.run(:host => "localhost", :port => 8080) do |ws|
    ws.onopen do |handshake|
      puts "WebSocket connection open"

      ws.send "Hello Client, you connected to #{handshake.path}"
    end

    ws.onclose { puts "Connection closed" }

    ws.onmessage do |msg|
      bad_response = {status: "error", message: "Client message format is wrong"}.to_json
      begin
        msg = JSON.parse(msg)
        token = msg.token
      rescue => e
        ws.send({status: "error", message: "#{e.to_s}"})
      end
    end
  end
end