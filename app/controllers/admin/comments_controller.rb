class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    @post_comment = Comment.find_by(id: params[:id])  # post_id パラメータは不要です
    if @post_comment
      @post_comment.destroy
      flash[:success] = "コメントが削除されました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end
    redirect_to request.referer
  end

end