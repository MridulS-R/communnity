class CreateBusinessEntities < ActiveRecord::Migration[7.1]
  def change
    create_table :business_entities do |t|
      t.string :entity_uid, null: false
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :pincode
      t.string :phone
      t.string :email
      t.string :category
      t.integer :status, null: false, default: 0
      t.datetime :last_verified_at
      t.decimal :source_confidence, precision: 5, scale: 2
      t.jsonb :extra, null: false, default: {}
      t.timestamps
    end
    add_index :business_entities, :entity_uid, unique: true
    add_index :business_entities, :status
  end
end

