class UsersController < ApplicationController
  def update
    if current_user
      UpdateTweet.new(current_user, params, flash).go
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:user, :tweet, :tweet_id)
  end
end


