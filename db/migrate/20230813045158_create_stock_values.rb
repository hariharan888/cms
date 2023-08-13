class CreateStockValues < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_values do |t|
      t.references  :stock,           null: false, foreign_key: true
      t.float       :open,            null: false
      t.float       :close,           null: false
      t.float       :high,            null: false
      t.float       :low,             null: false
      t.integer     :volume,          null: false
      t.datetime    :time,            null: false
      t.integer     :resolution,      null: false, default: 0

      t.timestamps
    end
    add_index :stock_values, %i[stock_id time resolution], unique: true
  end
end
