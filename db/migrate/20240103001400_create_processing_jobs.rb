class CreateProcessingJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :processing_jobs do |t|
      t.references :ingestion_batch, null: false, foreign_key: true
      t.integer :step, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.jsonb :metrics, null: false, default: {}
      t.datetime :started_at
      t.datetime :finished_at
      t.text :error
      t.timestamps
    end
    add_index :processing_jobs, :step
    add_index :processing_jobs, :status
  end
end

