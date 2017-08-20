require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eventsatpenn
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over settings specified
    # here. Application configuration goes into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set calendar first-day of week to Sunday, since this 'Murica
    config.beginning_of_week = :sunday

    Raven.configure do |config|
      config.dsn = 'https://bc380f8287694c2d9a3597b374e6dd07:27a8dc2c1cea49d3af537d6a49778394@sentry.io/205950'
    end
  end
end
