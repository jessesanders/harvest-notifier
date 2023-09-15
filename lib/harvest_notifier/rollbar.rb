# frozen_string_literal: true

if ENV.fetch("ROLLBAR_ACCESS_TOKEN", false)
  require "rollbar"

  Rollbar.configure do |config|
    config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]
  end

  Rollbar.info("Hello world!") # Sending an arbitrary message to Rollbar
end
