class MySessionsController < Devise::SessionsController

  
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.persisted?
      sign_in(resource_name, resource)
      token = resource.generate_authentication_token
      render json: { token: token, role: resource.role }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
  


  private

  # Extrae}ct the actual JWT of auth Header
  def current_token
    request.env['warden-jwt_auth.token']
  end
end
