module Api
  class PurchasesController < ApplicationController
    def create
      user = current_user()
      return render json: { error: "User not authenticated" }, status: :unauthorized unless user
    
      purchase = Purchase.new(purchase_params.merge(user: user))
    
      if params[:coupon_code]
        coupon = Coupon.find_by(code: params[:coupon_code])
        if coupon.used_by_user_count(user) >= (coupon.max_count || Float::INFINITY)
          return render json: { error: "Coupon usage limit reached for this user" }, status: :forbidden
        end
    
    
      
    
        purchase.coupon_id = coupon.id 

        apply_coupon_to_purchase(coupon, purchase)


      purchase.total_amount = calculate_total_amount(purchase.items)
      Rails.logger.info "Coupon found: #{coupon.inspect}"
      Rails.logger.info "Purchase before save: #{purchase.inspect}"
      if purchase.save
        UserCoupon.create(user: user, coupon: coupon) if coupon.present?
        render json: { message: "Purchase completed with coupon.", total: purchase.total_amount }
      else
        render json: purchase.errors, status: :unprocessable_entity
      end
      elsif purchase.save
        render json: purchase, status: :created
      else
        render json: purchase.errors, status: :unprocessable_entity
      end
    end

    
    def purchase_params
      params.require(:purchase).permit(:user_id, :coupon_code, :coupon_id, items: [])
    end

    def coupon_can_be_used_by_user?(coupon, user)
      user_coupon_count = UserCoupon.where(user: user, coupon: coupon).count
      user_coupon_count < coupon.max_count
    end
    
    

    def decrement_coupon_usage_for_user(coupon, user)
      UserCoupon.create(user: user, coupon: coupon) if coupon
    end

    def apply_coupon_to_purchase(coupon, purchase)

    end
  end
end
