# app/controllers/api/customer/coupons_controller.rb

module Api
    module Customer
      class CouponsController < ApplicationController

        def verify
          coupon = Coupon.find_by(code: params[:code])
          return render json: { error: "Coupon not found" }, status: :not_found if coupon.nil?
          purchase_total = params[:purchase_total].to_f
  
          if !coupon.active
            return render json: { error: "Coupon is not active" }, status: :forbidden
          end
          
          if coupon.used_by_user_count(current_user) >= (coupon.max_count || Float::INFINITY)
            return render json: { error: "Coupon usage limit reached for this user" }, status: :forbidden
          end
        
  
          user_coupon_count = UserCoupon.where(user: current_user, coupon: coupon).count
          if coupon.max_count.present? && user_coupon_count >= coupon.max_count
            return render json: { error: "Coupon usage limit reached for this user" }, status: :forbidden
          end
  
          if purchase_total < coupon.min_purchase_value
            return render json: { error: "Purchase total is less than minimum required for coupon" }, status: :forbidden
          end
  
          render json: {
            id: coupon.id,
            description: coupon.description,
            discount_type: coupon.discount_type,
            discount_value: coupon.discount_value,
            max_amount: coupon.max_amount,
            min_purchase_value: coupon.min_purchase_value,
            max_count: coupon.max_count
          }, status: :ok
        end
        
        def coupon_already_used_to_limit?(coupon, user)
          user_coupon_count = Purchase.where(user: user, coupon: coupon).count
          coupon.max_count.present? && user_coupon_count >= coupon.max_count
        end
        
        
  

        def coupon_already_used?(coupon, user)
          UserCoupon.exists?(user: user, coupon: coupon)
        end

        def times_used_by_user(coupon, user)
          UserCoupon.where(user: user, coupon: coupon).count
        end

        def coupon_can_be_used_by_user?(coupon, user)
          user_coupon_count = UserCoupon.where(user: user, coupon: coupon).count
          coupon.max_count.nil? || user_coupon_count < coupon.max_count
        end
        
          render json: { error: "Coupon has already been used or limit reached" }, status: :forbidden
        end

            
        
        def redeem
          coupon = Coupon.find(params[:id])
        
          if current_user.nil?
            render json: { error: "User not authenticated" }, status: :unauthorized
            return
          end
        

        end
        
          



  
        def format_discount(coupon)
          return "Invalid discount data" if coupon.discount_type.nil? || coupon.discount_value.nil?
          coupon.discount_type == 'percentage' ? "#{coupon.discount_value}%" : "$#{coupon.discount_value}"
        end         
      end
    end

    

  