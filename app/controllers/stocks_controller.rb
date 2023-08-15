class StocksController < ApplicationController
  def index
    @pagy, @records = pagy(Stock.all)
  end
end
