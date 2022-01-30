class WalletsController < ApplicationController
  def show
    user = User.find(params[:user_id])
    @wallet = user.wallet
  end

  def index
    
  end
end
