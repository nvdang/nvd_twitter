class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.create(comment_params)
    @comment.tweet = @tweet
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
          format.html { redirect_to user_tweets_url }
          format.js 
      end
       #redirect_to user_tweets_path
    else
       flash[:error] = "Reply with text field can't be blank or too long"
       redirect_to user_tweets_path
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.find(params[:id])
    @comment.tweet = @tweet
    @comment.user = current_user
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to user_tweets_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
    #redirect_to user_tweets_path
  end
 
   private
    def comment_params
      params.require(:comment).permit(:commenter, :text, :user_id)
    end
end
