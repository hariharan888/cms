class StockCode < ApplicationRecord
  belongs_to :stock
  enum :code_type, { isin: 0, nse: 1, bse: 2, mc: 3 }
end
