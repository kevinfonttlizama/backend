class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :coupon, optional: true 
  # belongs_to :UserCoupon
  has_many :items

end
