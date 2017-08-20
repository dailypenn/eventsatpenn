require_relative 'boot'
require 'raven'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eventsatpenn
  class Application < Rails::Application

    Raven.configure do |config|
      config.dsn = ENV['SENTRY_DSN']
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over settings specified
    # here. Application configuration goes into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set calendar first-day of week to Sunday, since this 'Murica
    config.beginning_of_week = :sunday
  end
end
