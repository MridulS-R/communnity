class VerificationEvent < ApplicationRecord
  belongs_to :business_entity

  enum kind: { auto_check: 0, phone_ping: 1, email_ping: 2, user_feedback: 3 }
  enum result: { passed: 0, failed: 1 }
end

