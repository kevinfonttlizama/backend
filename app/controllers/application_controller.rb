class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token



  def after_sign_up_path_for(resource)
    new_user_session_path 
  end

  def check_admin
    user = current_user
    Rails.logger.info "Attempting admin check for user: #{user.inspect}"
    unless user && user.admin?
      Rails.logger.info "Access denied. Current user is not an admin: #{user.inspect}"
      render json: { error: 'Acceso no autorizado' }, status: :unauthorized
      return
    end
    Rails.logger.info "Access granted. Current user is an admin: #{user.inspect}"
  end
  
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    return nil if token.blank?
  
    decoded_token = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })
    user_id = decoded_token[0]['user_id']
    user = User.find_by(id: user_id)
    Rails.logger.info "Current user: #{user.inspect}"
    user
  rescue JWT::DecodeError
    nil
  end
end
