class CreateChangeEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :change_events do |t|
      t.references :business_entity, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.jsonb :data, null: false, default: {}
      t.datetime :detected_at
      t.timestamps
    end
    add_index :change_events, :kind
    add_index :change_events, :detected_at
  end
end

