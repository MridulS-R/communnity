class CreateApiRequestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :api_request_logs do |t|
      t.references :api_key, null: false, foreign_key: true
      t.string :endpoint
      t.string :http_method
      t.integer :status
      t.integer :duration_ms
      t.jsonb :params, null: false, default: {}
      t.string :ip
      t.timestamps
    end
    add_index :api_request_logs, :endpoint
    add_index :api_request_logs, :created_at
  end
end

