# config valid only for current version of Capistrano
lock "3.10.1"

set :application, "basic-rails"
set :repo_url, "git@github.com:tzmfreedom/basic-rails.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, 'tmp/pids', 'tmp/sockets'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# set :rbenv_type, :user # or :system, depends on your rbenv setup
# set :rbenv_ruby, File.read('.ruby-version').strip

task :precompile do
  config = Capistrano::BundleRsync::Config
  run_locally do
    Bundler.with_clean_env do
      within config.local_release_path do
        execute :mkdir, "-p #{config.local_base_path}/shared/tmp/cache"
        execute :ln, "-s #{config.local_base_path}/shared/tmp/cache #{config.local_release_path}/tmp/cache"
        execute :bundle, "install -j4 --path #{config.local_base_path}/bundle"
        execute :bundle, 'exec rake assets:precompile'
        execute :unlink, "#{config.local_release_path}/tmp/cache"
        execute :mv, '.env.docker .env'
      end
    end
  end
end

before 'bundle_rsync:rsync_release', 'precompile'