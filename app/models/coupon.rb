class Coupon < ApplicationRecord
  before_save :set_default_max_count
  has_many :user_coupons
  has_many :users, through: :user_coupons
  validates :code, presence: true, uniqueness: true
  validates :discount_type, presence: true
  validates :discount_value, presence: true
  validates :max_amount, presence: true
  validates :min_purchase_value, presence: true
  # validates :description, presence: true

  def used_by_user_count(user)
    Purchase.where(user: user, coupon: self).count
  end
  
  private

  def set_default_max_count
    self.max_count ||= 1
  end
end
