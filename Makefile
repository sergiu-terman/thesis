all:
	nohup rerun ruby app.rb </dev/null &>/dev/null &
	nohup rerun bundle exec sidekiq -r ./env.rb </dev/null &>/dev/null &
	nohup rerun ruby lib/web_sockets/notify_socket.rb </dev/null &>/dev/null &

sinatra:
	rerun ruby app.rb

sidekiq:
	rerun bundle exec sidekiq -r ./env.rb

socket:
	rerun ruby lib/web_sockets/notify_socket.rb