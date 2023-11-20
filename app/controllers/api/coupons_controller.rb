module Api
  class CouponsController < ApplicationController
    before_action :set_coupon, only: [:show, :update, :destroy]
    before_action :check_admin, only: [:destroy]

    # GET /api/coupons
    def index
      @coupons = Coupon.all
      render json: @coupons
    end

    # GET /api/coupons/1
    def show
      render json: @coupon
    end

    # POST /api/coupons
    def create
      @coupon = Coupon.new(coupon_params)
      if @coupon.save
        render json: @coupon, status: :created
      else
        render json: @coupon.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/coupons/1
    def update
      if @coupon.update(coupon_params)
        render json: @coupon
      else
        render json: @coupon.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/coupons/1
    def destroy
      @coupon.destroy
    end

    private
      def set_coupon
        @coupon = Coupon.find(params[:id])
      end

      private
      def coupon_params
        params.require(:coupon).permit(:code, :discount_type, :discount_value, :max_amount, :min_purchase_value, :active, :max_count)
      end
      private

      def check_admin
        unless current_user&.admin?
          render json: { error: 'Acceso no autorizado' }, status: :unauthorized
          return
        end
      end
  end
end
