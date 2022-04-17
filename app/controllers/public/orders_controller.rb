class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @shipping_cost = 800
    @total_payment = @total + @shipping_cost
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @order.postal_code = params[:postal_code]
      @order.address = params[:address]
      @order.name = params[:name]
    end
  end

  def complete
    
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_details = @order.order_details.new
        @order_details.item_id = cart_item.item.id
        @order_details.image = cart_item.item.image
        @order_details.name = cart_item.item.name
        @order_details.with_tax_price = cart_item.item.with_tax_price
        @order_details.amount = cart_item.amount
        @order_details.subtotal = cart_item.subtotal
        @order_details.total = cart_item.total
        @order_details.save
        redirect_to complete_path
        current_customer.cart_items.destroy_all
      end
    
    redirect_to complete_path
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:image, :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
