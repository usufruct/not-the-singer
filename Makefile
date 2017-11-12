deps:
	bundle install

test:
	/usr/local/opt/memcached/bin/memcached -d -A -p 11212	
	bundle exec rspec
	echo shutdown | nc localhost 11212

.PHONY: deps rspec
