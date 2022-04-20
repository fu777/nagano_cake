class Public::HomesController < ApplicationController

  def top
    @item = Item.limit(4).order(created_at: :desc).where(is_active: true)
    @genres = Genre.all
  end

  def about
  end

end
