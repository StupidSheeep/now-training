class Public::BookmarksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.bookmarks.new(post: @post)
    if @like.save
      redirect_to request.referer, notice: 'ブックマークしました!'
    else
      redirect_to request.referer, alert: 'ブックマークに失敗しました'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.bookmarks.find_by(post: @post)
    @like.destroy
    redirect_to request.referer, notice: 'ブックマークを外しました'
  end

end
