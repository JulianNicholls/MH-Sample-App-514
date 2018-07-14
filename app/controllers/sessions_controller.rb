class SessionsController < ApplicationController
  def new
  end

  def create
    # Creating an instance variable allows for better testing
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      log_in @user
      session_params[:remember_me] == '1' ? remember(@user) : forget(@user)
  
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email or password.' # Ensure it only appears once
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def session_params
    params[:session]
  end
end
