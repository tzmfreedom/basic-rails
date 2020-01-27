Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  config.action_controller.perform_caching = true
  # Enable/disable caching. By default caching is disabled.
  config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
  }

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :letter_opener_web
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {
    host: 'localhost:3000'
  }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  BetterErrors::Middleware.allow_ip! '0.0.0.0/0'
  BetterErrors.use_pry!
  config.log_tags = [:request_id]

  is_stackprof         =  ENV['ENABLE_STACKPROF'].to_i.nonzero?
  stackprof_mode       = (ENV['STACKPROF_MODE']       || :wall).to_sym
  stackprof_interval   = (ENV['STACKPROF_INTERVAL']   || 1000).to_i
  stackprof_save_every = (ENV['STACKPROF_SAVE_EVERY'] || 1).to_i
  stackprof_path       =  ENV['STACKPROF_PATH']       || 'tmp/stackprof/'
  config.middleware.use StackProf::Middleware, enabled:    is_stackprof,
                                               mode:       stackprof_mode,
                                               raw:        true,
                                               interval:   stackprof_interval,
                                               save_every: stackprof_save_every,
                                               path:       stackprof_path
end
