class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def index
    @users = @q_users.result().paginate(page: params[:page])
  end
  
  def after_sign_in_path_for(resource)
  current_user_path
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      if logged_in?
        flash[:success] = "Account created!"
      else
        log_in @user
        flash[:success] = "Welcome to Unter!"
      end
      redirect_to @user
    else
      flash[:danger] = "Sign up Fail"
      render :new
    end
  end
  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :phone, :licenseN, 
                                    :password, :password_confirmation, :role, :rentalCharge)
    end
end