class UsersController < ApplicationController
  def update
    if current_user
      UpdateTweet.new(current_user, user_params, flash).go
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.permit(:user, :tweet, :tweet_id)
  end
end


