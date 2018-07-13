class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
    else
      flash[:danger] = 'Invalid email or password.'
      render :new
    end
  end

  def destroy
  end

  private

  def session_params
    params[:session]
  end
end
