source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'sidekiq'
gem 'redis'
gem 'kaminari'
gem 'activerecord-import'
gem 'dotenv-rails'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
# gem 'omniauth-line'
gem 'draper'
gem 'redis-rails'
gem 'mysql2'
gem 'unicorn'
# gem 'pg'
gem 'aws-sdk', '~> 3'
gem 'figaro'
gem 'whenever'
gem 'aasm'
gem 'bootsnap', require: false
gem 'rack-cors', require: 'rack/cors'
# gem 'racli'
# gem 'spring-commands-racli', github: 'tzmfreedom/spring-commands-racli'
# gem 'ahoy_matey'
gem 'ransack'
gem 'rails_event_store'
gem 'rails_event_store-browser'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'hirb'
  # gem 'hirb-unicode'
  gem 'awesome_print'
  gem 'rubocop', require: false
  gem 'seed-fu'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  gem 'better_errors'
  gem 'bullet'
  gem 'brakeman', require: false
  gem 'stackprof'
  gem 'memory_profiler'
  gem 'rack-mini-profiler'
  gem 'pygments.rb', require: false
  gem 'benchmark-ips'
  gem 'letter_opener_web'
  gem 'annotate', require: false
  gem 'binding_of_caller'
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  # gem 'capistrano3-puma'
  gem 'capistrano-bundle_rsync'
#  gem 'hologram'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'simplecov', :require => false
end
