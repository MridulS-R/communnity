class DatasetExport < ApplicationRecord
  belongs_to :dataset_package

  enum status: { queued: 0, running: 1, completed: 2, failed: 3 }
end

