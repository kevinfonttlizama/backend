class Coupon < ApplicationRecord
  enum discount_type: { flat: 0, percentage: 1 }

  validates :code, presence: true, uniqueness: true
  validates :discount_value, presence: true
  validate :immutable_discount, on: :update

  before_save :default_values

  def immutable_discount
    if active_changed?(from: false, to: true) && discount_value_changed?
      errors.add(:discount_value, "can't be changed after activation")
    end
  end

  def default_values
    self.count_used ||= 0
  end

  # Logic to apply the coupon...
end
