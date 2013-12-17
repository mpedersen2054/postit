class SessionsController < ApplicationController
  def new
    # just used to render the login form
  end

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}, you've successfully logged in"
      redirect_to root_path
    else
      flash[:error] = "There was something wrong with this username and/or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've successfully logged out"
    redirect_to root_path
  end
end
