# app/controllers/api/customer/coupons_controller.rb

module Api
    module Customer
      class CouponsController < ApplicationController

        def verify
          coupon = Coupon.find_by(code: params[:code])
        
          if coupon.nil?
            render json: { error: "Coupon not found" }, status: :not_found
          elsif !coupon.active
            render json: { error: "Coupon is not active" }, status: :forbidden
          elsif coupon_already_used?(coupon, current_user) # Pasar el usuario actual como segundo argumento
            render json: { error: "Coupon has already been used" }, status: :forbidden
          else
            render json: { 
              id: coupon.id, 
              description: coupon.description, 
              discount_type: coupon.discount_type, 
              discount_value: coupon.discount_value 
            }, status: :ok
          end
        end
            
        
        def redeem
          begin
            decoded_token = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.secret_key_base, true, { algorithm: 'HS256' })
            user_id = decoded_token[0]['user_id'] # Adjust according to your token's payload structure
            @current_user = User.find(user_id)
          rescue JWT::DecodeError => e
            Rails.logger.info "JWT Decode Error: #{e.message}"
          end
          Rails.logger.info "Authorization Header: #{request.headers['Authorization']}"
          Rails.logger.info "Manually Decoded Current User: #{@current_user.inspect}"
          Rails.logger.info "Current User: #{current_user.inspect}"
          coupon = Coupon.find(params[:id])
        
          if current_user.nil?
            render json: { error: "User not authenticated" }, status: :unauthorized
            return
          end
        
          if UserCoupon.exists?(user: current_user, coupon: coupon)
            render json: { error: "Coupon has already been used" }, status: :forbidden
          else
            # Asocia el cupón con el usuario actual solo si no lo ha canjeado antes
            current_user.coupons << coupon
            render json: { message: "Coupon redeemed successfully" }, status: :ok
          end
        end
        

  private

   def coupon_already_used?(coupon, user)
     UserCoupon.exists?(user: user, coupon: coupon)
   end
  end
        
      
        
        private
        
        def format_discount(coupon)
          return "Invalid discount data" if coupon.discount_type.nil? || coupon.discount_value.nil?
          coupon.discount_type == 'percentage' ? "#{coupon.discount_value}%" : "$#{coupon.discount_value}"
        end
      
  
        private       
        
  
        def format_discount(coupon)
          coupon.discount_type == 'percentage' ? "#{coupon.discount_value}%" : "$#{coupon.discount_value}"
        end
      end
    end

  