class Public::UsersController < ApplicationController
   before_action :authenticate_user!, except: [:index]
   before_action :is_matching_login_user, only: [:edit, :update]
   before_action :ensure_guest_user, only: [:edit]
  # before_action :set_user, except: [:index]
  # before_action :trim_introduction

  def index
    redirect_to new_user_registration_path
  end

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.map(&:post)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_my_page_path, notice: "変更内容を保存しました"
    else
      render "edit"
    end
  end

  def withdrawal
    if current_user.update(is_deleted: true)
      sign_out current_user
      flash[:success] = "退会が完了しました。"
      redirect_to root_path
    else
      flash[:error] = "退会処理中にエラーが発生しました。もう一度お試しください。"
      redirect_to users_my_page_edit_path(current_user)
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_my_page_path
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  # def trim_introduction
  #   # Introductionに対してgsubメソッドを使用して、改行やスペースを1文字に置換する
  #   introduction = introduction.gsub(/[\r\n\s　]+/, ' ')
  # end

end
