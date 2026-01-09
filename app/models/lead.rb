class Lead < ApplicationRecord
  validates :name, :email, :company, :role, :use_case, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :consent, acceptance: true
end

