class ReportsController < ApplicationController
  before_filter :authenticate!

	helper ReportsHelper
	
  def index
    wsclient = Api::WorkShare::V1::Session.restore(session[:workshare_session])
    @reports = view_context.group_by_type(wsclient.all_files)
  end

  def show
  end

end
