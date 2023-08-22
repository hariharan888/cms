class AddDiscardedAtToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at

    add_column :stocks, :discarded_at, :datetime
    add_index :stocks, :discarded_at

    add_column :stock_groups, :discarded_at, :datetime
    add_index :stock_groups, :discarded_at

    add_column :stock_group_junctions, :discarded_at, :datetime
    add_index :stock_group_junctions, :discarded_at

    add_column :stock_codes, :discarded_at, :datetime
    add_index :stock_codes, :discarded_at

    add_column :stock_values, :discarded_at, :datetime
    add_index :stock_values, :discarded_at
  end
end
