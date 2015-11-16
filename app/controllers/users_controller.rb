class UsersController < ApplicationController
  def index
     @user = current_user
     @users_following = @user.following
     @users_follower = @user.followers
  end
   
  def following
    @users = User.all
  end
end
