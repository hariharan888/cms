class StockValue < ApplicationRecord
  belongs_to :stock
  enum :resolution, { day: 0 } 
end
