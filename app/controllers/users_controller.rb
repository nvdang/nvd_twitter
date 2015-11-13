class UsersController < ApplicationController
  def index
     @user = current_user
     @users_following = @user.following
     @users_follower = @user.followers
     @tweets = current_user.feed.order("created_at DESC")
  end
   
  def following
    @users = User.all
  end
  
  def followers
  end
  
end
