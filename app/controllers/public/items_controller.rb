class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :is_active)
  end
  
end
