class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to show_url}
      format.js
    end
    #redirect_to following_user_path(@user)
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to show_url}
      format.js
    end
    #redirect_to following_user_path(@user)
  end
end
