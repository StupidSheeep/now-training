class Public::UsersController < ApplicationController
   before_action :authenticate_user!, except: [:index]
  # before_action :set_user, except: [:index]

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
    user = current_user
    if user.update(user_params)
      redirect_to users_my_page_path, notice: "You have updated user successfully."
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

end
