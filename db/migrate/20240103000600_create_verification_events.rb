class CreateVerificationEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :verification_events do |t|
      t.references :business_entity, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.integer :result, null: false, default: 0
      t.decimal :score, precision: 5, scale: 2
      t.jsonb :payload, null: false, default: {}
      t.datetime :occurred_at
      t.timestamps
    end
    add_index :verification_events, :kind
    add_index :verification_events, :result
  end
end

