# app/controllers/api/customer/coupons_controller.rb

module Api
    module Customer
      class CouponsController < ApplicationController
        before_action :authenticate_user!
  
        def verify
          coupon = Coupon.find_by(code: params[:code])
        
          if coupon.nil?
            render json: { error: "Coupon not found" }, status: :not_found
          elsif !coupon.active
            render json: { error: "Coupon is not active" }, status: :forbidden
          elsif coupon_already_used?(coupon)
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
        
        
        private
        
        def format_discount(coupon)
          return "Invalid discount data" if coupon.discount_type.nil? || coupon.discount_value.nil?
          coupon.discount_type == 'percentage' ? "#{coupon.discount_value}%" : "$#{coupon.discount_value}"
        end
        
          
  
        def redeem
          coupon = Coupon.find(params[:id])
  
          if coupon.nil?
            render json: { error: "Coupon not found" }, status: :not_found
          elsif !coupon.active
            render json: { error: "Coupon is not active" }, status: :forbidden
          elsif coupon_already_used?(coupon)
            render json: { error: "Coupon has already been used" }, status: :forbidden
          else
            # Aquí deberías implementar la lógica para marcar el cupón como usado por este cliente
            render json: { message: "Coupon redeemed successfully" }, status: :ok
          end
        end
  
        private
  
        def coupon_already_used?(coupon)
          # Implementa la lógica para verificar si el cupón ya ha sido usado por el usuario actual
          # Esto depende de cómo estés rastreando el uso de los cupones en tu aplicación
        end
  
        def format_discount(coupon)
          coupon.discount_type == 'percentage' ? "#{coupon.discount_value}%" : "$#{coupon.discount_value}"
        end
      end
    end
  end
  