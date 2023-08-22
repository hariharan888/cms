class StockValue < ApplicationRecord
  include Discard::Model
  belongs_to :stock
  enum :resolution, { day: 0 } 
end
