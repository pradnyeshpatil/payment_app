class WalletsController < ApplicationController
  def show
    if current_user
      @wallet = current_user.wallet
    else
      redirect_to new_user_session_path
    end
  end
end
