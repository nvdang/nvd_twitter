class TweetsController < ApplicationController
  def index
    @user = current_user
    #@tweet = @user.tweets.build
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
  
  def show
    @user = current_user
    @tweet = @user.tweets.find(params[:id])
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
    redirect_to user_tweets_path
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:text,:user_id,:picture)
  end
end
