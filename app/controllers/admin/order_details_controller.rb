class Admin::OrderDetailsController < ApplicationController

  skip_before_action :authenticate_customer!, only: [:update]
  before_action :authenticate_admin!, only: [:update]

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id])
      # if params[:order_detail][:making_status] == "production"
      #   @order.update(status: "production")
      # elsif params[:order_detail][:making_status] != "production_completed"
      # else
      #   @order.update(status: "ready_to_ship")
      # end
      @order_detail.update(order_detail_params)
    redirect_to admin_order_path
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
