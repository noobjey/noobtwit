require 'rails_helper'
require 'support/login_helper'

RSpec.feature "TwitterServices:", type: :feature do
  include LoginHelper

  before do
    @user ||= create_twitter_user
    @service = TwitterService.new(@user)
  end

  it "#tweet_count" do
    VCR.use_cassette('twitter user info') do
      expect(@service.my_tweet_count).to eq(88)
    end
  end

  it "#followers" do
    VCR.use_cassette('twitter user info') do
      expect(@service.followers).to eq(54)
    end
  end

  it "#following" do
    VCR.use_cassette('twitter user info') do
      expect(@service.following).to eq(65)
    end
  end

end
