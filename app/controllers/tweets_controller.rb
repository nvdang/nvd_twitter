class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweet = @user.tweets.build
    @tweets = current_user.feed.order("created_at DESC")
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
    params.require(:tweet).permit(:text,:user_id)
  end
end
