class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweets = current_user.feed.paginate(page: params[:page], per_page: 10).order("created_at DESC")
    if current_user.profile.present?
      @url = current_user.profile.avatar.url
      @path = user_profile_path(@user, @user.profile)
     else
        @url = "default.png"
        @path = new_user_profile_path(@user)
      end
      respond_to do |format|
        format.html
        format.js
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
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to user_tweets_url }
        format.js 
      else
        format.html { redirect_to user_tweets_url }
        format.json { render json: @tweet.errors }
        format.js
      end
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
