class CreateSources < ActiveRecord::Migration[7.1]
  def change
    create_table :sources do |t|
      t.string :name, null: false
      t.integer :kind, null: false, default: 0
      t.string :url
      t.string :terms_url
      t.boolean :active, default: true, null: false
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end
    add_index :sources, :kind
    add_index :sources, :active
  end
end

