class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  def generate_password_reset!
    update!(reset_password_token: SecureRandom.urlsafe_base64(32), reset_password_sent_at: Time.current)
  end

  def clear_password_reset!
    update_columns(reset_password_token: nil, reset_password_sent_at: nil)
  end

  def password_reset_period_valid?
    return false if reset_password_token.blank? || reset_password_sent_at.blank?
    reset_password_sent_at > 2.hours.ago
  end
end
