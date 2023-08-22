class StocksController < ApplicationController
  before_action :set_record, only: %i[show update destroy]

  def index
    scope = Stock.kept.ransack(ransack_params)
    scope.sorts = params[:order_by] if params[:order_by].present?
    @pagy, @records = pagy(scope.result)
  end

  def bulk_delete
    params.require(:stock).permit(ids: [])
    Stock.where(id: params[:stock][:ids]).discard_all

    render json: { message: 'Records deleted successfully' }, status: 200
  end

  private

  def set_record
    @record = Stock.find(params[:id])
  end

  def ransack_params
    return nil if params[:q].nil?

    q_params = params[:q]

    search_text = q_params.delete(:search)
    q_params.merge!({ name_cont: search_text }) if search_text.present?

    q_params
  end
end
