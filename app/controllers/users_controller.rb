class UsersController < ApplicationController
  def update
    if current_user && legit_tweet?
      current_user.tweet(params[:user][:tweet])
      flash[:success] = "Tweet posted."
    elsif current_user && params[:tweet_id]
      current_user.favorite(params[:tweet_id])
    else
      flash[:error] = "There was an error posting your tweet, please try again."
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:tweet)
  end

  def legit_tweet?
    tweet_not_empty? && valid_length?(params[:user][:tweet])
  end

  def tweet_not_empty?
    params[:user] && params[:user][:tweet]
  end

  def valid_length?(tweet)
    tweet.length > 0 && tweet.length < 140
  end
end
