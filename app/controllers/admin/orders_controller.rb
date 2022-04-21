class Admin::OrdersController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show, :update]

  def show
    @order = Order.find(params[:id])
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    @order_details = @order.order_details
  end

  def index
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    if params[:order][:status] == 1
      @order.order_details.each do |order_detail|
        order_detail.making_status = 1
        order_detail.update(making_status: order_detail.making_status)
      end
    end
    order.update(order_params)
    redirect_to admin_order_path
  end

  private

  def order_params
    params.require(:order).permit(:image, :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
