class CommentsController < ApplicationController
  def create
    @user = current_user
    @tweet = @user.tweets.find(params[:tweet_id])
    @comment = @tweet.comments.create(comment_params)
    redirect_to user_tweet_path(@user,@tweet)
  end
  
  def destroy
    @user = current_user
    @tweet = @user.tweets.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    redirect_to user_tweet_path(@user,@tweet)
  end
  
   private
    def comment_params
      params.require(:comment).permit(:commenter, :text)
    end
end
