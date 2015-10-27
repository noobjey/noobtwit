module LoginHelper

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode           = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                   uid:         '84891952',
                                                                   info:        {
                                                                     name:     'Jason Wright',
                                                                     nickname: 'noobjey'
                                                                   },

                                                                   credentials: {
                                                                     token:  '84891952-N6wBz8PfWIXDlXdMzCJdChM0Bcj4nlQdbDCx4d2yj',
                                                                     secret: 'yVsJTKGfpVJy74ShYVkhLiWal8W3L8TgcSbazvzh3wZWY'
                                                                   }
                                                                 })
  end

  def login_user()
    Capybara.app = Noobtwit::Application
    stub_omniauth
    visit root_path

    click_on "Login with Twitter"
    expect(current_path).to eq(dashboard_path)
  end

  def logged_in_user()
    User.find_by(uid: '84891952')
  end

end
