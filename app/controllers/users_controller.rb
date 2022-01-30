class UsersController < Devise::RegistrationsController
  before_action :set_user, only: [:edit, :show, :update]

  def index
    @users = User.all  
  end

  def create
    @user = User.new user_params
    @user.images.attach(params[:user][:image])
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to root_path, message: 'User created Successfully' }
        format.json { render json: @user, status: :created }
      else
        format.html { render 'new'}
        format.json { render json: @user.errors.full_messages.uniq, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show

  end

  def update 
    @user.assign_attributes(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, message: 'User updated Successfully' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render 'edit'}
        format.json { render json: @user.errors.full_messages.uniq, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    user_attr = [:email, :password, :password_confirmation, :pan_number]
    user_attr << :verified if current_user.admin?
    params.require(:user).permit(user_attr)
  end
end
