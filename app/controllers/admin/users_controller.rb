class Admin::UsersController < ApplicationController
before_action :authenticate_admin!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end


  def toggle_status
    @user = User.find(params[:id])
    @user.toggle!(:is_deleted)
    redirect_to admin_root_path, notice: "ユーザーのステータスを更新しました。"
  end

end
