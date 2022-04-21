class SearchesController < ApplicationController

  def search
    @items = Item.search(params[:search])
    @genres = Genre.all
  end

end
