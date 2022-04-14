class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @numbers = *[1..10]
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_items.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end
  
  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    # if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
    #   @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    #   @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path
    # else
    #   @cart_items = CartItem.all
    #   @cart_item.save
    #   redirect_to cart_items_path
    # end
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
