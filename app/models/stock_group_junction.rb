class StockGroupJunction < ApplicationRecord
  belongs_to :stock
  belongs_to :stock_group
end
