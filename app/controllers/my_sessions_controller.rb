class MySessionsController < Devise::SessionsController
  def create
    super do |user|
      if user.persisted?
        render json: { token: user.authentication_token, role: user.role }, status: :ok and return
      end
    end
  end
end
