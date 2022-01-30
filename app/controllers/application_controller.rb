class ApplicationController < ActionController::Base

  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
