class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where(params[:user_id])
  end

  def update
      if current_user.update(user_params)
        redirect_to mypage_path
      else
        redirect_to user_edit_path
      end
  end

  def edit
    @user = current_user
  end

  def mypage
    @user = current_user
    @posts = current_user.posts.where(params[:user_id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile)
  end

end

