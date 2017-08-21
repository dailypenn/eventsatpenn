require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eventsatpenn
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Set timezone to eastern US
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    # Settings in config/environments/* take precedence over settings specified
    # here. Application configuration goes into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set calendar first-day of week to Sunday, since this 'Murica
    config.beginning_of_week = :sunday

    # Google tag manager
    GoogleTagManager.gtm_id = Rails.application.secrets.gtm_id

    # filtered parameters that won't be sent to sentry
    config.filter_parameters << :password
  end
end
