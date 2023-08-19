class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from StandardError, with: :handle_error
  rescue_from AbstractController::ActionNotFound, with: -> { respond_with_error 'Resource not found', 404 }
  rescue_from ActiveRecord::RecordNotFound, with: -> { respond_with_error 'Resource not found', 404 }
  rescue_from(ActiveRecord::RecordInvalid) do |pme|
    respond_with_error pme.to_s, 400
  end
  rescue_from(ActionController::ParameterMissing) do |pme|
    respond_with_error pme.to_s, 400
  end
  rescue_from(ActionController::BadRequest) do |pme|
    respond_with_error pme.to_s, 400
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def paginate
    ->(it) { it.limit(per_page).offset(page) }
  end

  def page
    params[:p]&.to_i || Pagy::DEFAULT[:page]
  end

  def per_page
    params[:per_page]&.to_i || Pagy::DEFAULT[:items]
  end

  def pagy_get_vars(collection, vars)
    vars[:items] = [Pagy::DEFAULT[:items], per_page].min
    vars[:page] ||= page
    vars[:count] ||= (count = collection.count(:all)).is_a?(Hash) ? count.size : count
    vars
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end

  private

  def handle_error(error, error_message = 'Unexpected internal server error', error_code = 500)
    log_error(error)
    msg = { error_ts: Time.now.to_i,
            error_message:,
            error_code: }

    # send_mail_to_developer(e, err_msg, msg)
    render json: msg, status: error_code
  end

  def respond_with_error(error_message = 'An error occured', error_code = 400)
    msg = { error_message:, error_code: }
    render json: msg, status: error_code
  end

  def log_error(error)
    logger.error { "Error type: #{error.class.name}" }
    logger.error { "Error: #{error}" }
    logger.error { "Error stack: #{error.backtrace[0..100]} " }
  end
end
