class WebhookDelivery < ApplicationRecord
  belongs_to :webhook_endpoint
  enum status: { queued: 0, delivered: 1, failed: 2 }
end

