class User < ApplicationRecord
  has_many :purchases
  has_many :user_coupons
  has_many :coupons, through: :user_coupons
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  before_save :ensure_authentication_token

  def admin?
    role == 'admin'
  end


  def generate_authentication_token #genering jwt 
    payload = { user_id: self.id }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end


  private

  def set_default_role
    self.role ||= 'customer'
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end



  
end
