class CreateLeads < ActiveRecord::Migration[7.1]
  def change
    create_table :leads do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :company, null: false
      t.string :role, null: false
      t.string :use_case, null: false
      t.string :city
      t.string :industry
      t.boolean :interest_datasets, default: false
      t.boolean :interest_api, default: false
      t.boolean :consent, default: false
      t.timestamps
    end
    add_index :leads, :email
  end
end

