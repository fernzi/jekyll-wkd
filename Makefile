build: test
	bundle exec rake build

release: test
	bundle exec rake release

test: vendor/bundle
	bundle exec rake test standard

install: vendor/bundle
	bundle exec rake install

clean:
	$(RM) -r pkg vendor Gemfile.lock

bundle: vendor/bundle
vendor/bundle:
	bundle config --local path 'vendor/bundle'
	bundle install

.PHONY: build bundle clean install release test
