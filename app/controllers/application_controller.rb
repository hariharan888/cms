class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def paginate
    ->(it){ it.limit(per_page).offset(page) }
  end

  def page
    params[:p]&.to_i || Pagy::DEFAULT[:page]
  end

  def per_page
    params[:per_page]&.to_i || Pagy::DEFAULT[:items]
  end

  def pagy_get_vars(collection, vars)
    vars[:items] = [Pagy::DEFAULT[:items], per_page].min()
    vars[:page] ||= page
    vars[:count] ||= (count = collection.count(:all)).is_a?(Hash) ? count.size : count
    vars
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
