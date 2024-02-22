class SessionsController < ApplicationController


  def new
  end

  def create
    user = Attendee.find_by_email(params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out successfully!"
  end
end
