class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.string :email
      t.string :token, null: false
      t.boolean :active, default: true, null: false
      t.datetime :last_used_at
      t.timestamps
    end
    add_index :api_keys, :token, unique: true
    add_index :api_keys, :email
  end
end

