class ChangeEvent < ApplicationRecord
  belongs_to :business_entity

  enum kind: { moved: 0, closed: 1, opened: 2, address_changed: 3, phone_changed: 4 }
end

