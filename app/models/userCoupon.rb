class UserCoupon < ApplicationRecord
    belongs_to :user
    belongs_to :coupon
  
    # Puedes añadir validaciones adicionales si es necesario
  end
  