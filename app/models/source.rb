class Source < ApplicationRecord
  has_many :ingestion_batches, dependent: :nullify
  has_many :raw_records, dependent: :nullify

  enum kind: { csv_upload: 0, api: 1, partner_feed: 2, public_directory: 3 }

  validates :name, presence: true
end

