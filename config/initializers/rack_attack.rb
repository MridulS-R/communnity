class Rack::Attack
  # Use in-process store (OK for single dyno; switch to Redis later)
  cache.store = ActiveSupport::Cache::MemoryStore.new

  # Throttle lead submissions by IP: 5 req / minute
  throttle("leads/ip", limit: 5, period: 60) do |req|
    req.ip if req.path == "/leads" && req.post?
  end

  # Extract API token from Authorization header
  def self.api_token(req)
    return unless req.path.start_with?("/v1/")
    auth = req.get_header("HTTP_AUTHORIZATION")
    return unless auth&.start_with?("Bearer ")
    auth.split(" ", 2).last
  end

  # Throttle API calls per token: 60 req / minute
  throttle("api/token", limit: 60, period: 60) do |req|
    api_token(req)
  end
end

