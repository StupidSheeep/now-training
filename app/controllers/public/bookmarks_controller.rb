class Public::BookmarksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.bookmarks.new(post: @post)
    if @like.save
      redirect_to request.referer, notice: 'Liked!'
    else
      redirect_to request.referer, alert: 'Failed to like.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.bookmarks.find_by(post: @post)
    @like.destroy
    redirect_to request.referer, notice: 'Unliked!'
  end

end
