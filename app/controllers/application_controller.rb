class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= Attendee.find_by(id: session[:user_id])
    elsif session[:user_email]
      @current_user ||= Attendee.find_by(email: session[:user_email])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to root_path unless logged_in?
  end

  def require_login
    redirect_to login_path, alert: "Please log in to continue" unless current_user
  end
end
