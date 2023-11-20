# app/controllers/api/customer/coupons_controller.rb

module Api
    module Customer
      class CouponsController < ApplicationController

        def verify
          coupon = Coupon.find_by(code: params[:code])
          purchase_total = params[:purchase_total].to_f
          if coupon.nil?
            render json: { error: "Coupon not found" }, status: :not_found
          elsif !coupon.active
            render json: { error: "Coupon is not active" }, status: :forbidden
          elsif coupon_already_used?(coupon, current_user)
            render json: { error: "Coupon has already been used" }, status: :forbidden
          elsif times_used_by_user(coupon, current_user) >= (coupon.max_count || Float::INFINITY)
            render json: { error: "Coupon usage limit reached for this user" }, status: :forbidden
          elsif purchase_total < coupon.min_purchase_value
            render json: { error: "Purchase total is less than minimum required for coupon" }, status: :forbidden
          else
            render json: {
              id: coupon.id,
              description: coupon.description,
              discount_type: coupon.discount_type,
              discount_value: coupon.discount_value,
              max_amount: coupon.max_amount, # Asegúrate de que esto esté incluido
              min_purchase_value: coupon.min_purchase_value # Y esto también
            }, status: :ok
          end
        end
            
        
        def redeem
          coupon = Coupon.find(params[:id])
        
          if current_user.nil?
            render json: { error: "User not authenticated" }, status: :unauthorized
            return
          end
        
          if coupon_can_be_used_by_user?(coupon, current_user)
            decrement_coupon_usage_for_user(coupon, current_user)
            render json: { message: "Coupon redeemed successfully" }, status: :ok
          else
            render json: { error: "Coupon has already been used or limit reached" }, status: :forbidden
          end
        end
        

        private

        def times_used_by_user(coupon, user)
          UserCoupon.where(user: user, coupon: coupon).count
        end
  
        def coupon_already_used?(coupon, user)
          UserCoupon.exists?(user: user, coupon: coupon)
        end
  
        def format_discount(coupon)
          return "Invalid discount data" if coupon.discount_type.nil? || coupon.discount_value.nil?
          coupon.discount_type == 'percentage' ? "#{coupon.discount_value}%" : "$#{coupon.discount_value}"
        end         
      end
    end
  end  
    

  