class SearchesController < ApplicationController
  
  def search
    @genres = Genre.search(params[:search])
    @items = Item.search(params[:search])
  end
  
end
