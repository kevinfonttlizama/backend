class Purchase < ApplicationRecord
    belongs_to :user
    # has_many :purchase_items
     has_many :items


    def redeem_coupon
        purchase = Purchase.find(params[:purchase_id])
        coupon = Coupon.find_by(code: params[:coupon_code])
    
        if coupon && coupon.valid_for_purchase?(purchase)

          purchase.user.coupons << coupon

    
          render json: { message: "Cupón aplicado con éxito." }
        else
          render json: { error: "Cupón no válido para esta compra." }, status: :unprocessable_entity
        end
      end
  end