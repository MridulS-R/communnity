class IngestionBatch < ApplicationRecord
  belongs_to :source
  has_many :raw_records, dependent: :nullify
  has_many :processing_jobs, dependent: :destroy

  enum status: { pending: 0, running: 1, completed: 2, failed: 3 }
end

