.PHONY: test
test:
	bin/rspec .

.PHONY: install
install:
	bundle install --path=vendor/bundle -j4
	bundle binstubs annotate capistrano rubocop sidekiq
	bundle exec rails generate bootstrap:install static

.PHONY: migrate
migrate:
	bundle exec rake db:migrate

.PHONY: seed
seed:
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
