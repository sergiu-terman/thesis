all: kill sinatra-s sidekiq-s

sinatra:
	rerun 'rackup -s thin -E production config.ru'

sinatra-s:
	rerun rackup </dev/null &>/dev/null &

sidekiq:
	rerun 'bundle exec sidekiq -r ./env.rb'

sidekiq-s:
	rerun 'bundle exec sidekiq -r ./env.rb' </dev/null &>/dev/null &

kill:
	ps -A | grep rerun | awk 'NR > 2 { system("kill "prev) } { prev = cret } { cret = $$1 }'
