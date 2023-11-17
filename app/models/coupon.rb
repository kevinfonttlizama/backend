class Coupon < ApplicationRecord
  has_many :user_coupons
  has_many :users, through: :user_coupons
  validates :code, presence: true, uniqueness: true
  validates :discount_type, presence: true
  validates :discount_value, presence: true
  validates :max_amount, presence: true
  validates :min_purchase_value, presence: true
  #validates :description, presence: true
end
