APP_PORT := 3000
RUBY_VERSION := $(shell cat .ruby-version)

.PHONY: test
test:
	bin/rspec .

.PHONY: install
install: bundle
	bundle binstubs annotate capistrano rubocop sidekiq
	bundle exec rails generate bootstrap:install static
	bundle exec rails generate active_admin:install
	make db/init

.PHONY: install/ruby
install/ruby: install/rbenv
ifneq ($(shell rbenv version 2> /dev/null | grep $(RUBY_VERSION)), $(RUBY_VERSION))
	rbenv install $(RUBY_VERSION)
endif

.PHONY: install/rbenv
install/rbenv:
ifeq ($(shell command -v rbenv 2> /dev/null),)
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
endif

.PHONY: bundle
bundle: install/bundler
	bundle install --path vendor/bundle -j4

.PHONY: install/bundler
install/bundler:
	gem install bundler

.PHONY: console
console:
	bundle exec rails console

.PHONY: server
server:
	bundle exec rails server -b 0.0.0.0 -p $(APP_PORT)

.PHONY: db/init
db/init: db/create db/migrate db/seed

.PHONY: db/migrate
db/migrate:
	bundle exec rake db:migrate

.PHONY: db/create
db/create:
	bundle exec rake db:create

.PHONY: db/seed
db/seed:
	bundle exec rake db:seed

.PHONY: run
run:
	bundle exec rails s

.PHONY: run_queue
run_queue:
	bundle exec sidekiq -C config/sidekiq.yml

.PHONY: deploy
deploy:
	bundle exec cap production deploy 

.PHONY: docker/build
docker/build:
	docker-compose build

.PHONY: docker/up
docker/up:
	docker-compose up -d

.PHONY: docker/stop
docker/stop:
	docker-compose stop

.PHONY: docker/down
docker/down:
	docker-compose down

.PHONY: docker/migrate
docker/migrate:
	docker-compose run app bin/rake db:create db:migrate

.PHONY: docker/seed
docker/seed:
	docker-compose run app bin/rake db:seed

.PHONY: heroku
heroku:
ifeq ($(shell command -v heroku 2>/dev/null),)
	brew install heroku
endif

.PHONY: heroku/deploy
heroku/deploy: heroku
	git push heroku master

.PHONY: heroku/create
heroku/create: heroku
	heroku apps:create $(APP_NAME)
