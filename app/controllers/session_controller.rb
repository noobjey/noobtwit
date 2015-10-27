class SessionController < ApplicationController
  def new
  end

  def create
    if user = User.find_or_create_from_oauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end
end
