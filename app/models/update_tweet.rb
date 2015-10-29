class UpdateTweet
  attr_reader :user,
              :params,
              :flash

  def initialize(user, params, flash)
    @user   = user
    @params = params
    @flash = flash
  end

  def go
    if create_tweet? && legit_tweet?
      user.tweet(params[:user][:tweet])
      flash[:success] = "Tweet posted."
    elsif favorite?
      user.favorite(params[:tweet])
      flash[:success] = "Tweet favorited."
    else
      flash[:danger] = "There was an error posting your tweet, please try again."
    end
  end


  private

  def valid_input?
    legit_tweet? || favorite?
  end

  def favorite?
    !params[:tweet_id].nil?
  end

  def create_tweet?
    !params[:tweet].nil?
  end

  def legit_tweet?
    tweet_not_empty? && valid_length?(params[:tweet])
  end

  def tweet_not_empty?
    !params[:tweet].empty?
  end

  def valid_length?(tweet)
    tweet.length > 0 && tweet.length < 140
  end
end
