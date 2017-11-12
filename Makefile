deps:
	bundle install

test:
	/usr/local/opt/memcached/bin/memcached -d -A -p 11212	
	bundle exec foreman run --env .env,.env_test rspec
	echo shutdown | nc localhost 11212

start:
	bundle exec foreman run --env .env puma

.PHONY: deps rspec start
