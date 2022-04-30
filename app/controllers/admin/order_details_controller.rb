class Admin::OrderDetailsController < ApplicationController

  skip_before_action :authenticate_customer!, only: [:update]
  before_action :authenticate_admin!, only: [:update]

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
      if params[:order_detail][:making_status] == "production"
        @order_detail.order.update(status: "production")
      elsif params[:order_detail][:making_status] == "production_completed"
        status = 0
        @order.order_details.each do |order_detail|
          if order_detail.making_status != 'production_completed'
            status = 1
          end
        end
        if status == 0
          @order_detail.order.update(status: "ready_to_ship")
        end
      else
      end
    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
