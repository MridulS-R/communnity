class EntityLink < ApplicationRecord
  belongs_to :business_entity
  belongs_to :raw_record
end

