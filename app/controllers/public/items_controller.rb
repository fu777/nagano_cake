class Public::ItemsController < ApplicationController

  def index
    @items = Item.where(is_active: true)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :is_active)
  end

end
