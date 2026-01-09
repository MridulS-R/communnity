class QualitySnapshot < ApplicationRecord
  belongs_to :scope, polymorphic: true, optional: true
end

