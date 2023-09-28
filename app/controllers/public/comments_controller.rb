class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    post_comment = @post.comments.new(post_comment_params)
    post_comment.user = current_user
    post_comment.score = Language.get_data(post_comment_params[:post_comment])  #この行を追加
    post_comment.save
  end


  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:comment).permit(:post_comment,:user_id,:post_id)
  end

end