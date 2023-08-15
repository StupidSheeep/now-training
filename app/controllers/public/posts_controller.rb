class Public::PostsController < ApplicationController

  def index
  end

  def show
    @post = Post.find(params[:id])
    @genre = Genre.find(@post.genre_id)
  end

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "You have created book successfully."
    else
      @posts = Post.all
      render 'index'
    end

  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :target_time, :genre_id)
  end


end
