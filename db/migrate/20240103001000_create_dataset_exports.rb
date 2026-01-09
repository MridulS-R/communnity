class CreateDatasetExports < ActiveRecord::Migration[7.1]
  def change
    create_table :dataset_exports do |t|
      t.references :dataset_package, null: false, foreign_key: true
      t.string :format, null: false
      t.integer :status, null: false, default: 0
      t.integer :row_count
      t.string :url
      t.string :created_by
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps
    end
    add_index :dataset_exports, :status
  end
end

