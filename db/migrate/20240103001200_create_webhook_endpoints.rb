class CreateWebhookEndpoints < ActiveRecord::Migration[7.1]
  def change
    create_table :webhook_endpoints do |t|
      t.string :name
      t.string :url, null: false
      t.string :secret
      t.boolean :active, default: true, null: false
      t.text :event_types, array: true, default: []
      t.timestamps
    end
    add_index :webhook_endpoints, :active
  end
end

