class Admin::OrderDetailsController < ApplicationController

  skip_before_action :authenticate_customer!, only: [:update]
  before_action :authenticate_admin!, only: [:update]

  def update
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
    @order = @order_details.order
    if params[:order_detail][:making_status] == 2
      order.update(status: 2)
    end
    order_detail.update(making_status: params[:order_detail][:making_status])
    status = 0
    @order = Order.find(params[:id])
    @order.order_details.each do |order_detail|
      if order_detail.making_status != 4
        status = 1
      end
    end
    if status == 0
      order.update(status: 4)
    end
    redirect_to admin_orders_path
  end

end
