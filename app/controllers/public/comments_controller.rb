class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.comments.new(post_comment_params)
    @post_comment.user = current_user
    @post_comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @post_comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @post_comment.destroy
    redirect_to post_path(@post_comment.post)
  end

  private

  def post_comment_params
    params.require(:comment).permit(:post_comment,:user_id,:post_id)
  end

end