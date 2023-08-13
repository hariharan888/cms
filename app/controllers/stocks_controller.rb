class StocksController < ApplicationController
  def index
    @stocks = Stock.all.limit(10)
  end
end
