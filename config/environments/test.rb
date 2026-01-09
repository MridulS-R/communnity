require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.public_file_server.enabled = true
  config.public_file_server.headers = { 'Cache-Control' => "public, max-age=3600" }
  config.action_dispatch.show_exceptions = false
  config.active_support.deprecation = :stderr
end

