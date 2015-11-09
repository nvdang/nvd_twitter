class UsersController < ApplicationController
  def index
     @user = current_user
     @users_following = @user.all_following
     @users_follower = @user.followers
  end
   
  def following
    @user = current_user
    @users = User.all
  end
  
  def followers
    @users = User.all
  end
  
  def follow
    @user = User.find(params[:id])
    if current_user == @user
      flash[:error] = "Not Follow Yourself"
    else
      current_user.follow(@user)
      redirect_to users_path
    end
  end
  
  def unfollow
    @user = User.find(params[:id])
    if current_user
      current_user.stop_following(@user)
      redirect_to users_path
    end
  end
end
