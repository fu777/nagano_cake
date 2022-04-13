class Public::HomesController < ApplicationController
  
  def top
    @item = Item.limit(4)
  end

  def about
  end
  
end
