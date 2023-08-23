class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end


  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿が削除されました。"
  end

  # ...

  private

  def set_post
    @post = Post.find(params[:id])
  end

end
