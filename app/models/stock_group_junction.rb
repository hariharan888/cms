class StockGroupJunction < ApplicationRecord
  include Discard::Model
  belongs_to :stock
  belongs_to :stock_group
end
