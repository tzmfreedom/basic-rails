gem 'redis-rails'
if yes?('db: mysql?')
  gem 'mysql2'
  copy_file 'config/database.mysql2.yml', 'config/database.yml'
elsif yes? 'db: postgres'
  gem 'pg'
  copy_file 'config/database.pg.yml', 'config/database.yml'
end

gem 'figaro' if yes? 'db: figaro?'
gem 'dotenv' if yes? 'db: dotenv?'
gem 'faraday'
gem 'rack-cors', require: 'rack/cors'
gem 'aws-sdk-s3' if yes? 'aws: s3?'
gem 'draper' if yes? 'decorator: draper?'

gem 'kaminari'
gem 'ransack'
gem 'font-awesome-rails'
gem 'activerecord-import'
gem 'banken'

gem_group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'hirb'
  gem 'awesome_print'
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'rails_best_practices'
end

gem_group :development do
  gem 'better_errors'
  gem 'bullet'
  gem 'annotate', require: false
  gem 'binding_of_caller'
  gem 'seed-fu', '~> 2.3'
  gem 'guard-rspec'
  gem 'stackprof'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

environment <<~'APPLICATION_RB'
  config.session_store :redis_store, servers: [ENV['SESSION_STORE_URI']],
                                     expire_after: 1.day,
                                     key: "_#{Rails.application.class.parent_name.downcase}_admin_session"
  config.cache_store = :redis_store, ENV['CACHE_STORE_URI'], { expires_in: 90.minutes }
  config.log_tags = [:request_id]

  config.i18n.default_locale = :ja
  config.time_zone = 'Asia/Tokyo'

  config.action_controller.include_all_helpers = false

  config.generators.stylesheets = false
  config.generators.javascripts = false
  config.generators.helper      = false
  config.generators do |g|
    g.factory_bot dir: 'spec/factories'
    g.fixture_replacement :factory_bot, dir: 'spec/factories'
    g.test_framework :rspec, view_specs: false,
                             helper_specs: false,
                             controller_specs: false,
                             routing_specs: false
  end

  config.paths.add 'lib', eager_load: true
APPLICATION_RB

environment <<'PRODUCTION_RB', env: 'development'
  BetterErrors::Middleware.allow_ip! '0.0.0.0/0'

  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end

  is_stackprof         =  ENV['ENABLE_STACKPROF'].to_i.nonzero?
  stackprof_mode       = (ENV['STACKPROF_MODE']       || :wall).to_sym
  stackprof_interval   = (ENV['STACKPROF_INTERVAL']   || 1000).to_i
  stackprof_save_every = (ENV['STACKPROF_SAVE_EVERY'] || 1).to_i
  stackprof_path       =  ENV['STACKPROF_PATH']       || 'tmp/stackprof/'
  config.middleware.use StackProf::Middleware, enabled: is_stackprof,
                                               mode: stackprof_mode,
                                               raw: true,
                                               interval: stackprof_interval,
                                               save_every: stackprof_save_every,
                                               path:       stackprof_path

PRODUCTION_RB

template 'config/initializers/ransack.rb', 'config/initializers/ransack.rb'

append_to_file '.gitignore' do
  <<~CODE
    /vendor/bundle
    /.idea
    /config/application.yml
    /coverage
  CODE
end

template 'docker-compose.yml.tt', 'docker-compose.yml'

template 'Dockerfile.tt', 'Dockerfile'
template '.dockerignore'
template 'Makefile.tt', 'Makefile'
