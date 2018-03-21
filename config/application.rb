require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BasicRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.cache_store = :redis_store, ENV['CACHE_STORE_URI'], { expires_in: 90.minutes }
    config.session_store :redis_store, servers: [ENV['SESSION_STORE_URI']], expire_after: 1.day
    config.active_job.queue_adapter = :sidekiq

    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'

    # class HogeMiddleWare
    #   def initialize(app)
    #     @app = app
    #   end
    #
    #   def call(env)
    #     @hoge ||= Time.zone.now.strftime('%Y/%m/%d %H:%M:%S')
    #     Rails.logger.info(@hoge)
    #     @app.call env
    #   end
    # end
    #
    # config.middleware.use HogeMiddleWare
  end
end
