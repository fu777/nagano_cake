class Admin::OrdersController < ApplicationController

  skip_before_action :authenticate_customer!, only: [:update]
  before_action :authenticate_admin!, only: [:index, :show, :update]

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    @new_status = Order.new
    @new_making_status = OrderDetail.new
  end

  def index
    @order_page = Order.page(params[:page])
    @orders = params[:customer_id].present? ? Customer.find(params[:customer_id]).orders : Order.page(params[:page])
  end

  def update
    @order = Order.find(params[:id])
    # if params[:order][:status] == "payment_confirmation"
      # @order.order_details.each do |order_detail|
        # order_detail.making_status = 1
        # order_detail.update(making_status: order_detail.making_status)
      # end
    # end
    @order.update(order_params)
    redirect_to admin_order_path
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
