class DatasetPackage < ApplicationRecord
  has_many :dataset_exports, dependent: :destroy

  scope :active, -> { where(active: true) }
end

