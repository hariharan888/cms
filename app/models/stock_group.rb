class StockGroup < ApplicationRecord
  include Discard::Model
  enum :type, { custom: 0, stock_index: 1 }

  has_many :stock_group_junctions
  has_many :stocks, through: :stock_group_junctions
end
