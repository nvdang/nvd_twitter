class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @user = current_user
    @tweets = @user.tweets.order("created_at DESC")
  end
  
  def show
    @user = current_user
    @tweet = @user.tweets.find(params[:id])
  end
  
  def create
    @user = current_user
    @tweet = @user.tweets.new(tweet_params)
    @tweet.save
    redirect_to user_tweets_path
  end
  
  def destroy
    @user = current_user
    @tweet = @user.tweets.find(params[:id])
    @tweet.destroy
    redirect_to user_tweets_path
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:text,:user_id)
  end
end
