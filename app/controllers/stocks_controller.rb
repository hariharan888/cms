class StocksController < ApplicationController
  before_action :set_record, except: %i[index create]

  def index
    @pagy, @records = pagy(Stock.all.ransack(params[:q]).result)
  end

  private

  def set_record
    @record = Stock.find(params[:id])
  end
end
