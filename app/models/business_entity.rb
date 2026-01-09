class BusinessEntity < ApplicationRecord
  has_many :entity_links, dependent: :destroy
  has_many :raw_records, through: :entity_links
  has_many :verification_events, dependent: :destroy
  has_many :change_events, dependent: :destroy

  enum status: { active: 0, closed: 1 }

  validates :entity_uid, presence: true, uniqueness: true
end

