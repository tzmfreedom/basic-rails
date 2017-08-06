gem_group :development do
  gem 'better_errors'
  gem 'bullet'
  gem 'stackprof'
  gem 'memory_profiler'
  gem 'rack-mini-profiler'
  gem 'pygments.rb', require: false
  gem 'benchmark-ips'
  gem 'factory_girl_rails'
end

gem_group :test do
  gem 'rspec-rails'
end

gem_group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'hirb'
  gem 'awesome_print'
end

gem 'sidekiq'
gem 'capistrano-rails'
gem 'redis'
gem 'mysql2'
gem 'pg'
gem 'kaminari'
gem 'activerecord-import'
gem 'dotenv-rails'
gem 'omniauth-facebook'
gem 'rubocop', require: fales
gem 'devise'
gem 'draper'
gem 'activeadmin'
gem 'inherited_resources'
