require 'sentry-raven'

env = ENV.fetch('RAILS_ENV') { 'development' }

if env == 'production'
  Raven.configure do |config|
    dsn = Rails.application.secrets.sentry_dsn
    config.dsn = dsn
  end
end
