require 'shellwords'

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    source_paths.unshift(tempdir = Dir.mktmpdir("rails-template-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git :clone => [
      "--quiet",
      "https://github.com/mattbrictson/rails-template.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{rails-template/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git :checkout => branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def run_with_clean_bundler_env(cmd)
  return run(cmd) unless defined?(Bundler)
  Bundler.with_clean_env { run(cmd) }
end

gem_group :development do
  gem 'better_errors'
  gem 'bullet'
  gem 'stackprof'
  gem 'memory_profiler'
  gem 'rack-mini-profiler'
  gem 'pygments.rb', require: false
  gem 'benchmark-ips'
  gem 'factory_girl_rails'
  gem 'letter_opener_web'
  gem "annotate"
  gem "binding_of_caller"
end

gem_group :test do
  gem 'rspec-rails'
  gem "simplecov", :require => false
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
gem 'kaminari'
gem 'activerecord-import'
gem 'dotenv-rails'
gem 'omniauth-facebook'
gem 'rubocop', require: false
gem 'devise'
gem 'draper'
gem 'activeadmin'
gem 'inherited_resources'
gem 'twitter-bootstrap-rails'
gem 'redis-rails'

add_template_repository_to_source_path

after_bundle do
  git :init
  git add: '.'
  git commit: %Q{ -m 'Initial commit' }
end

route <<RUBY
if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
RUBY

environment 'config.action_mailer.delivery_method = :letter_opener_web', env: 'development'

template '.gitignore.tt', force: true
template '.ruby-version.tt', '.ruby-version'
template 'Makefile.tt'
apply 'config/template.rb'
