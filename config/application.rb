# frozen_string_literal: true

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module CommInnity
  class Application < Rails::Application
    config.load_defaults 7.1

    # Use PostgreSQL in all environments; DATABASE_URL driven in production.
    config.generators.system_tests = nil
    config.time_zone = "Asia/Kolkata"

    # Enable Rack::Attack for throttling
    config.middleware.use Rack::Attack
  end
end
