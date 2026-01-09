class RawRecord < ApplicationRecord
  belongs_to :source
  belongs_to :ingestion_batch
  has_many :entity_links, dependent: :destroy
  has_many :business_entities, through: :entity_links

  # Store original, mapped, and normalized forms
  store_accessor :payload
  store_accessor :mapped
  store_accessor :normalized
end

