class CreateWebhookDeliveries < ActiveRecord::Migration[7.1]
  def change
    create_table :webhook_deliveries do |t|
      t.references :webhook_endpoint, null: false, foreign_key: true
      t.string :event_type
      t.integer :status, null: false, default: 0
      t.integer :response_code
      t.integer :attempts, default: 0
      t.text :last_error
      t.jsonb :payload, null: false, default: {}
      t.datetime :delivered_at
      t.timestamps
    end
    add_index :webhook_deliveries, :status
    add_index :webhook_deliveries, :event_type
  end
end

