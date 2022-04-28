class Admin::ItemsController < ApplicationController
  
  before_action :authenticate_admin!, only: [:index, :show]

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      flash[:notice] = "商品を新規登録しました。"
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品を編集しました。"
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :is_active)
  end

end
