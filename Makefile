all: kill sinatra sidekiq socket

sinatra:
	rerun rackup </dev/null &>/dev/null &

sidekiq:
	rerun 'bundle exec sidekiq -r ./env.rb' </dev/null &>/dev/null &

socket:
	rerun 'ruby lib/web_sockets/notify_socket.rb' </dev/null &>/dev/null &

sinatra-v:
	rerun rackup

sidekiq-v:
	rerun 'bundle exec sidekiq -r ./env.rb'

socket-v:
	rerun 'ruby lib/web_sockets/notify_socket.rb'

kill:
	ps -A | grep rerun | awk 'NR > 2 { system("kill "prev) } { prev = cret } { cret = $$1 }'
