class CouponsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coupon, only: [:show, :update, :destroy]
  before_action :check_admin, only: [:create, :update, :destroy]



def check_admin
  redirect_to(root_path) unless current_user.admin?
end



  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      render json: @coupon, status: :created
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def check_admin
    render json: { error: 'Not authorized' }, status: :unauthorized unless current_user.admin?
  end

  def coupon_params
    params.require(:coupon).permit(:code, :discount_type, :discount_value, :max_count, :max_amount, :min_purchase_value, :active)
  end
end
