class Coupon < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :discount_type, presence: true
  validates :discount_value, presence: true
  validates :max_amount, presence: true
  validates :min_purchase_value, presence: true

  # Aquí puedes añadir cualquier otra lógica necesaria para tu modelo
end
