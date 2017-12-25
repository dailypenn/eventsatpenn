require_relative 'provision'
require_relative 'boot'
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "action_cable/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

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

    # filtered parameters that won't be sent to sentry
    config.filter_parameters << :password

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
