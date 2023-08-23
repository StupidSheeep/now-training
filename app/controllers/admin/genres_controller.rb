class Admin::GenresController < ApplicationController
  before_action :authenticate_admin! # Deviseの管理者認証

  def index
    @genres = Genre.order(created_at: :desc)
    @genre = Genre.new
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: 'Genre created successfully.'
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'Genre updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: 'Genre deleted successfully.'
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
