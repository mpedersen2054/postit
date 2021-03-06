class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You've successfully updated your profile"
      redirect_to user_path(@user)
    else
      flash[error] = "There was a problem with updating your profile"
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You've successfully registered, #{@user.username}"
      redirect_to root_path
    else
      render :new
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "Your not allowed to do that"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
