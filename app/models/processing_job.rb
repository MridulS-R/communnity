class ProcessingJob < ApplicationRecord
  belongs_to :ingestion_batch
  enum step: { ingest: 0, map: 1, normalize: 2, resolve: 3, verify: 4 }
  enum status: { queued: 0, running: 1, completed: 2, failed: 3 }
end

