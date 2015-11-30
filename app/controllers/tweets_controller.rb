class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweets = current_user.feed.order("created_at DESC")
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
  
  def suggest
    @user = current_user
    if @user.following.present?
       @users_following = @user.following
     else
       @users_following = []
     end
    @users = @users_following.order(:username).where("username like ?", "%#{params[:term]}%")  
    render json: @users.map(&:username) 
  end
  
  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
      if @tweet.save
        redirect_to user_tweets_path
      else
        flash[:error] = "Text field can't be blank or too longs"
        redirect_to user_tweets_path
      end
  end
  
  def destroy
    @user = current_user
    @tweet = @user.tweets.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to user_tweets_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end
  
  private
    def tweet_params
      params.require(:tweet).permit(:text,:user_id,:picture)
    end
end
