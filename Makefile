.PHONY: test
test:
	bin/rspec .

.PHONY: install
install:
	bundle install --path=vendor/bundle -j4
	bundle binstubs annotate capistrano rubocop sidekiq
	bundle exec rails generate bootstrap:install static

.PHONY: bundle
bundle:
	bundle install

.PHONY: console
console:
	bundle exec rails console

.PHONY: server
server:
	bundle exec rails server -b 0.0.0.0 -p 3000

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
	cap deploy 

.PHONY: docker/up
docker/up:
	docker-compose up -d

.PHONY: docker/stop
docker/stop:
	docker-compose stop

.PHONY: docker/down
docker/down:
	docker-compose down
