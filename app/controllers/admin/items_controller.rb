class Admin::ItemsController < ApplicationController

  skip_before_action :authenticate_customer!, only: [:new, :create, :update, :edit]
  before_action :authenticate_admin!, only: [:new, :index, :show, :create, :edit, :update]

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
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      flash[:notice] = "商品を新規登録しました。"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
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
