class SessionController < ApplicationController
  def new

  end

  def create
    byebug
    render text: request.env["omniauth.auth"].inspect
  end
end
