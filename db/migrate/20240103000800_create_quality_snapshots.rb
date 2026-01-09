class CreateQualitySnapshots < ActiveRecord::Migration[7.1]
  def change
    create_table :quality_snapshots do |t|
      t.string :scope_type
      t.bigint :scope_id
      t.decimal :duplicate_rate_pct, precision: 5, scale: 2
      t.decimal :accuracy_sample_pct, precision: 5, scale: 2
      t.integer :coverage_total
      t.integer :freshness_days_median
      t.datetime :computed_at
      t.jsonb :data, null: false, default: {}
      t.timestamps
    end
    add_index :quality_snapshots, [:scope_type, :scope_id]
    add_index :quality_snapshots, :computed_at
  end
end

