require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do
  let(:valid_session) {
    wsession = build(:wsession)
    wsession.authorize
    {workshare_session: wsession.dump_session}
  }

  let(:invalid_session) {
    {}
  }

  describe "GET index" do
    context "unauthorized user" do
      it "redirect to login" do
        get :index, {}, invalid_session
        expect(response).to redirect_to(login_path)
      end
    end
    
    context "authorized user" do
      it "assigns all files to @report" do
        get :index, {}, valid_session
        expect(assigns(:report)).to be_an_instance_of(Array)
      end

      it "render template 'index'" do
        get :index, {}, valid_session
        expect(response).to render_template("index")
      end
    end
    
  end

end
