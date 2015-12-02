class UsersController < ApplicationController
  def index
     @user = current_user
     @users = User.all
     if @user.following.present?
       @users_following = @user.following
     else
       @users_following = []
     end
     
     if @user.followers.present?
       @users_follower = @user.followers
     else
       @users_follower = []
     end
     
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
  
  def show
    @user = User.find(params[:id])
     if user_signed_in?
        if @user.profile.present?
          @url = @user.profile.avatar.url
        else
          @url = "default.png"
        end
     end
  end
end