class Public::PostsController < ApplicationController

  def index
    @post = Post.all
    @user = User.all
  end

  def show
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "内容を更新しました。"
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to users_my_page_path(current_user), notice: "投稿を削除しました。"
    else
      redirect_to post_path(@post), alert: "投稿の削除に失敗しました。"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :target_time, :level, :genre_id)
  end


end
