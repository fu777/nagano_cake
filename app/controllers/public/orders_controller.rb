class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @new_order = Order.new
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @shipping_cost = 800
    @total_payment = @total + @shipping_cost
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @address_new = current_customer.addresses.new
      @order.postal_code = params[:postal_code]
      @order.address = params[:address]
      @order.name = params[:name]
      if @address_new.save
      else
        render :new
      end
    end
  end

  def complete
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @customer = current_customer
    @order.status = 0
    @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.price = cart_item.item.with_tax_price
        @order_detail.amount = cart_item.amount
        @order_detail.making_status = 0
        @order_detail.save
      end
    redirect_to complete_path
    current_customer.cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
