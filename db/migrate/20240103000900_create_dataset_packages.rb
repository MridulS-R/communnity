class CreateDatasetPackages < ActiveRecord::Migration[7.1]
  def change
    create_table :dataset_packages do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.text :description
      t.jsonb :geography, null: false, default: {}
      t.text :industries, array: true, default: []
      t.integer :record_count, default: 0
      t.integer :freshness_days_median
      t.datetime :last_updated
      t.string :update_frequency
      t.text :formats, array: true, default: []
      t.jsonb :fields, null: false, default: []
      t.jsonb :quality, null: false, default: {}
      t.boolean :active, default: true, null: false
      t.timestamps
    end
    add_index :dataset_packages, :slug, unique: true
    add_index :dataset_packages, :active
  end
end

