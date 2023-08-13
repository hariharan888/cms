class CreateStockGroupJunctions < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_group_junctions do |t|
      t.references  :stock,           null: false, foreign_key: true
      t.references  :stock_group,     null: false, foreign_key: true

      t.timestamps
    end
    add_index :stock_group_junctions, %i[stock_id stock_group_id], unique: true
  end
end
