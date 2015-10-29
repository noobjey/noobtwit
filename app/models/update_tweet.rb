class UpdateTweet
  attr_reader :user,
              :params

  def initialize(user, params)
    @user   = user
    @params = params
  end

  def go
    if create_tweet? && legit_tweet?
      user.tweet(params[:user][:tweet])
      flash[:success] = "Tweet posted."
    elsif favorite?
      user.favorite(params[:tweet])
    else
      flash[:error] = "There was an error posting your tweet, please try again."
    end
  end


  private

  def valid_input?
    legit_tweet? || favorite?
  end

  def favorite?
    params[:tweet_id]
  end

  def create_tweet?
    params[:user] && params[:user][:tweet]
  end

  def legit_tweet?
    tweet_not_empty? && valid_length?(params[:user][:tweet])
  end

  def tweet_not_empty?
    !params[:user][:tweet].empty?
  end

  def valid_length?(tweet)
    tweet.length > 0 && tweet.length < 140
  end
end
