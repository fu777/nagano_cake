class Admin::GenresController < ApplicationController
  
  skip_before_action :authenticate_customer!, only: [:create, :update, :edit]
  before_action :authenticate_admin!, only: [:index, :create, :edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      flash[:notice] = "ジャンルを新規登録しました。"
      redirect_to admin_genres_path(@genre)
    else
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを編集しました。"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
