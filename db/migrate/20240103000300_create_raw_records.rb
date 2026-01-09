class CreateRawRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :raw_records do |t|
      t.references :source, null: false, foreign_key: true
      t.references :ingestion_batch, null: false, foreign_key: true
      t.string :external_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :pincode
      t.string :phone
      t.string :email
      t.string :category
      t.string :fingerprint
      t.jsonb :payload, null: false, default: {}
      t.jsonb :mapped, null: false, default: {}
      t.jsonb :normalized, null: false, default: {}
      t.timestamps
    end
    add_index :raw_records, :external_id
    add_index :raw_records, :fingerprint
    add_index :raw_records, [:source_id, :external_id]
  end
end

