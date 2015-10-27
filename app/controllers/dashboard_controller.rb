class DashboardController < ApplicationController

  def index
    if current_user
      render :index
    else
      flash[:warning] = "Please login to view your dashboard."
      redirect_to root_path
    end
  end
end
