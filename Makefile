DOCKER_COMPOSE_SUB_COMMAND = down start stop build
DOCKER_COMPOSE_COMMAND = docker-compose
DOCKER_COMMAND = docker
APP_PORT := 3000
RUBY_VERSION := $(shell cat .ruby-version)

.PHONY: test
test:
	$(MAKE) run COMMAND="make test"

.PHONY: init
init:
	$(MAKE) db/init

.PHONY: up
up: docker-sync/start docker/up

.PHONY: restart
restart: down up

.PHONY: app/console
app/console:
	$(DOCKER_COMPOSE_COMMAND) exec app /bin/bash

.PHONY: app/restart
app/restart:
	make run COMMAND='bundle exec rails restart'

.PHONY: db/up
db/up: docker-sync/start
	$(DOCKER_COMPOSE_COMMAND) up -d mysql redis localstack spring

.PHONY: docker/up
docker/up:
	$(DOCKER_COMPOSE_COMMAND) up -d

.PHONY: $(DOCKER_COMPOSE_SUB_COMMAND)
$(DOCKER_COMPOSE_SUB_COMMAND):
	$(DOCKER_COMPOSE_COMMAND) $@

.PHONY: run
run:
	$(DOCKER_COMPOSE_COMMAND) exec spring $(COMMAND)

.PHONY: console
console:
	$(MAKE) run COMMAND="/bin/bash"

.PHONY: rails/console
rails/console:
	$(MAKE) run COMMAND="bundle exec rails console"

.PHONY: bundle
bundle:
	$(MAKE) run COMMAND="bundle install --path vendor/bundle -j4"

.PHONY: server
server:
	bundle exec rails server -b 0.0.0.0 -p $(APP_PORT)

.PHONY: assets/precompile
assets/precompile:
	bin/rake assets:precompile

.PHONY: attach
attach:
ifdef NAME
	$(DOCKER_COMMAND) attach docker_$(NAME)
else
	$(DOCKER_COMMAND) attach docker_app
endif

.PHONY: db/init
db/init: db/drop db/create db/migrate db/seed annotate

.PHONY: db/drop
db/drop:
	$(MAKE) run COMMAND="bundle exec rake db:drop"

.PHONY: db/migrate
db/migrate:
	$(MAKE) run COMMAND="bundle exec rake db:migrate"

.PHONY: annotate
annotate:
	$(MAKE) run COMMAND="bundle exec annotate"

.PHONY: db/create
db/create:
	$(MAKE) run COMMAND="bundle exec rake db:create"

.PHONY: db/seed
db/seed:
	$(MAKE) run COMMAND="bundle exec rake db:seed_fu"

.PHONY: deploy
deploy:
	bundle exec cap production deploy

.PHONY: staging/deploy
staging/deploy:
	bundle exec cap staging deploy

.PHONY: heroku
heroku:
ifeq ($(shell command -v heroku 2>/dev/null),)
	brew install heroku
endif

.PHONY: guard
guard:
	$(MAKE) run COMMAND="bundle exec guard"

.PHONY: docker-sync
docker-sync:
ifeq ($(shell command -v docker-sync),)
	gem install docker-sync
	brew install unison
	brew tap eugenmayer/dockersync
	brew install eugenmayer/dockersync/unox
endif

.PHONY: docker-sync/start
docker-sync/start: docker-sync
	-@docker-sync start

.PHONY: logs
logs:
ifdef NAME
	$(DOCKER_COMPOSE_COMMAND) logs -f $(NAME)
else
	$(DOCKER_COMPOSE_COMMAND) logs -f app
endif

.PHONY: heroku/deploy
heroku/deploy: heroku
	git push heroku master

.PHONY: heroku/create
heroku/create: heroku
	heroku apps:create $(APP_NAME)
	heroku addons:create heroku-postgres
	heroku addons:create heroku-redis
	heroku addons:create papertrail

.PHONY: heroku/console
heroku/console: heroku
	heroku run bash

.PHONY: heroku/migrate
heroku/migrate: heroku
	heroku run bundle exec rake db:migrate

.PHONY: heroku/seed
heroku/seed: heroku
	heroku run bundle exec rake db:seed

.PHONY: heroku/logs
heroku/logs: heroku
	heroku logs

.PHONY: heroku/db/console
heroku/db/console: heroku
	heroku pg:psql
