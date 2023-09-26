class Public::BookmarksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = current_user.bookmarks.new(post: @post)
    like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.bookmarks.find_by(post: @post)
    like.destroy
  end

end
