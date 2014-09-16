class ReportsController < ApplicationController
  before_filter :authenticate!

  def index
    wsclient = Api::WorkShare::V1::Session.restore(session[:workshare_session])
    @report = wsclient.all_files
  end

  def show
  end

end
