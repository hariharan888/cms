class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from StandardError, with: :handle_error

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def paginate
    ->(it) { it.limit(per_page).offset(page) }
  end

  def page
    page_value = params[:p]&.to_i || Pagy::DEFAULT[:page]

    raise ActionController::BadRequest.new('Invalid page number') if page_value.zero?

    page_value
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
    case error
    when AbstractController::ActionNotFound, ActiveRecord::RecordNotFound
      return respond_with_error 'Resource not found', 404
    when ActiveRecord::RecordInvalid, ActionController::ParameterMissing, ActionController::BadRequest
      return respond_with_error error.message, 400
    else
      log_error(error)
      # send_mail_to_developer(e, err_msg, msg)
      return respond_with_error error_message, error_code
    end
  end

  def respond_with_error(error_message = 'An error occured', error_code = 400)
    msg = { error_ts: Time.now.to_i, error_message:, error_code: }
    render json: msg, status: error_code
  end

  def log_error(error)
    logger.error { "Error type: #{error.class.name}" }
    logger.error { "Error: #{error}" }
    logger.error { "Error stack: #{error.backtrace[0..100]} " }
  end
end
