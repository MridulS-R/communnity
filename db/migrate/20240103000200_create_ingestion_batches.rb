class CreateIngestionBatches < ActiveRecord::Migration[7.1]
  def change
    create_table :ingestion_batches do |t|
      t.references :source, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :total_count, default: 0
      t.integer :processed_count, default: 0
      t.integer :duplicate_count, default: 0
      t.datetime :started_at
      t.datetime :finished_at
      t.string :notes
      t.jsonb :metrics, null: false, default: {}
      t.timestamps
    end
    add_index :ingestion_batches, :status
  end
end

