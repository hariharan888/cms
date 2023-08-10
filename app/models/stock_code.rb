class StockCode < ApplicationRecord
  belongs_to :stock
  enum :code_type, { isin: 0, nse: 1, bse: 2, money_control: 3 }
end
