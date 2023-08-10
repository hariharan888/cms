class CreateStockCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_codes do |t|
      t.integer     :code_type,       null: false
      t.string      :value,           null: false
      t.references  :stock,           null: false, foreign_key: true
      t.timestamps
    end

    add_index :stock_codes, [:stock_id, :code_type], unique: true
    add_index :stock_codes, [:code_type, :value], unique: true
  end
end
