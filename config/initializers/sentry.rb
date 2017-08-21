env = ENV.fetch('RAILS_ENV') { 'development' }

if env == 'production'
  require 'sentry-raven'
  Raven.configure do |config|
    dsn = Rails.application.secrets.sentry_dsn
    config.dsn = dsn
  end
end
