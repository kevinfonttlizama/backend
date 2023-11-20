class AddCouponCodeToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :coupon_code, :string
  end
end
