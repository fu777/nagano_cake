class Public::OrdersController < ApplicationController
  
  def new
    @addresses = Address.all
    @customer = current_customer
    @customer_address = current_customer.address_display
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_items = @order.order_items.new
        @order_items.item_id = cart_item.item.id
        @order_items.image = cart_item.item.image
        @order_items.name = cart_item.item.name
        @order_items.with_tax_price = cart_item.item.with_tax_price
        @order_items.amount = cart_item.amount
        @order_items.subtotal = cart_item.subtotal
        @order_items.total = cart_item.total
        @order_items.save
        current_customer.cart_items.destroy_all
      end
  end

  def complete
  end

  def create
    
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
