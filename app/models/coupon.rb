class Coupon < ApplicationRecord
  has_many :user_coupons
  has_many :users, through: :user_coupons
  validates :code, presence: true, uniqueness: true
  validates :discount_type, presence: true
  validates :discount_value, presence: true
  validates :max_amount, presence: true
  validates :min_purchase_value, presence: true
  #validates :description, presence: true

  def valid_for_purchase?(purchase)
    # Ejemplo de validación: el cupón no se ha utilizado antes por este usuario
    !self.users.include?(purchase.user) &&
    # Ejemplo de validación: total de la compra supera un cierto monto
    purchase.total >= self.minimum_purchase_amount
    # Agrega aquí otras validaciones según tus reglas de negocio
  end
end
