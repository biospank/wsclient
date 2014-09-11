class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticated?
    session[:workshare_session]
  end

  def authenticate!
    if authenticated?
      return true
    else
      redirect_to login_url
    end
  end
end
