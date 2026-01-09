class ApiKey < ApplicationRecord
  before_create do
    self.token ||= SecureRandom.hex(24)
    self.active = true if active.nil?
  end

  scope :active, -> { where(active: true) }
end

