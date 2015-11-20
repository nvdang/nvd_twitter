class UsersController < ApplicationController
  def index
     @user = current_user
     @users_following = @user.following
     @users_follower = @user.followers
     if user_signed_in?
      if current_user.profile.present?
        @url = current_user.profile.avatar.url
        @path = user_profile_path(@user, @user.profile)
      else
        @url = "default.png"
        @path = new_user_profile_path(@user)
      end
    end 
  end 
   
  def following
    @users = User.all
  end
end
