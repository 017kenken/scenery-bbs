class UserController < ApplicationController
  before_action :set_user, only: [:show, :follow, :followers, :followees]

  def show
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
    @likes = @user.likees(Post)
    @posts = current_user.posts.where(params[:user_id])
    @followees = @user.followees(User)
    @followers = @user.followers(User)
  end

  def follow
    current_user.toggle_follow!(@user)
    if current_user.follows?(@user)
      redirect_back(fallback_location: root_path, notice: "フォローしました")
    else
      redirect_back(fallback_location: root_path, notice: "フォローを解除しました")
    end
  end

  def followees
    @followees = @user.followees(User)

    render :followees
  end

  def followers
    @followers = @user.followers(User)

    render :followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

