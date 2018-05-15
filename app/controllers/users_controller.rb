class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :phone, :licenseN, 
                                    :password, :password_confirmation, :role, :rentalCharge)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end