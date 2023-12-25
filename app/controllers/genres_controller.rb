class GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update, :destroy]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, notice: 'ジャンルが作成されました'
    else
      flash.now[:alert] = 'エラーがあります。'
      render 'index'
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: 'ジャンルが更新されました'
    else
      flash.now[:alert] = 'エラーがあります。'
      render 'edit'
    end
  end
  
  def destroy
    if @genre.destroy
      redirect_to genres_path, notice: 'ジャンルが削除されました'
    else
      flash.now[:alert] = 'エラーがあります。'
      render 'edit'
    end
  end  

private
  
  def set_genre
    @genre = Genre.find(params[:id])
  end
  
  def genre_params
    params.require(:genre).permit(:name)
  end

end


