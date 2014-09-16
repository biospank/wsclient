class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      wsclient = Api::WorkShare::V1::Session.new(@user.username, @user.password)
      begin 
        wsclient.authorize()
        session[:workshare_session] = wsclient.dump_session
        redirect_to reports_url
      rescue => e
        flash.now[:warning] = "Authentication failed"
        render "new"
      end
    else
      flash.now[:warning] = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to login_url, :notice => "Logged out!"
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
