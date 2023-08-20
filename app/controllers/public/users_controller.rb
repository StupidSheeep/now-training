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

end
