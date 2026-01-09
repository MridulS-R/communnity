class CreateEntityLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :entity_links do |t|
      t.references :business_entity, null: false, foreign_key: true
      t.references :raw_record, null: false, foreign_key: true
      t.string :match_method
      t.decimal :match_score, precision: 5, scale: 2
      t.datetime :matched_at
      t.timestamps
    end
    add_index :entity_links, [:business_entity_id, :raw_record_id], unique: true, name: 'index_entity_links_on_entity_and_record'
  end
end

