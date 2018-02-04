Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('SIDEKIQ_CLIENT_URI', '') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('SIDEKIQ_SERVER_URI', '') }
end