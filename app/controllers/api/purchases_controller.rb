module Api
  class PurchasesController < ApplicationController


    def create
      params.require(:purchase).permit(:user_id, items: [])

      user = current_user()

      unless user
        render json: { error: "User not authenticated" }, status: :unauthorized
        return
      end

      purchase = Purchase.new(purchase_params.merge(user: user))

      if params[:coupon_code]
        coupon = Coupon.find_by(code: params[:coupon_code])
        if coupon && coupon_can_be_used_by_user?(coupon, user)
          apply_coupon_to_purchase(coupon, purchase)
          if purchase.save
            decrement_coupon_usage_for_user(coupon, user)
            render json: { message: "Purchase completed with coupon.", total: purchase.total_amount }
          else
            render json: purchase.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Invalid or expired coupon" }, status: :forbidden
        end
      else
        if purchase.save
          render json: purchase, status: :created
        else
          render json: purchase.errors, status: :unprocessable_entity
        end
      end
    end

  
  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :coupon_code, items: [])
  end
  

  def coupon_can_be_used_by_user?(coupon, user)
    UserCoupon.where(user: user, coupon: coupon).count < (coupon.max_count || Float::INFINITY)
  end

  def decrement_coupon_usage_for_user(coupon, user)
    UserCoupon.create(user: user, coupon: coupon)
  
  end

  def apply_coupon_to_purchase(coupon, purchase)
  end
end
end
