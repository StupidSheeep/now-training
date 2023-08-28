class Public::RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user) # ユーザーをフォローするメソッドを呼び出す
    redirect_to request.referer
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user) # ユーザーのフォローを解除するメソッドを呼び出す
    redirect_to request.referer
  end

end
