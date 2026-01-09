require 'net/http'
require 'uri'

class LeadWebhookJob < ApplicationJob
  queue_as :default

  def perform(lead_id)
    url = ENV["LEAD_WEBHOOK_URL"]
    return unless url.present?
    lead = Lead.find_by(id: lead_id)
    return unless lead
    payload = lead.attributes.slice("name","email","company","role","use_case","city","industry","interest_datasets","interest_api")
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    req = Net::HTTP::Post.new(uri.request_uri, {"Content-Type"=>"application/json"})
    req.body = payload.to_json
    http.request(req)
  rescue => e
    Rails.logger.error("LeadWebhookJob error: #{e.class}: #{e.message}")
  end
end
