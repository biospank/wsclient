require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  let(:valid_attributes) {
    attributes_for(:user)
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_credentials) {
    attributes_for(:wsuser)
  }

  let(:invalid_credentials) {
    attributes_for(:user)
  }

  # describe "GET index" do
  #   it "assigns all sessions as @sessions" do
  #     session = Session.create! valid_attributes
  #     get :index, {}, valid_session
  #     expect(assigns(:sessions)).to eq([session])
  #   end
  # end
  #
  # describe "GET show" do
  #   it "assigns the requested session as @session" do
  #     session = Session.create! valid_attributes
  #     get :show, {:id => session.to_param}, valid_session
  #     expect(assigns(:session)).to eq(session)
  #   end
  # end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a(User)
      expect(assigns(:user).username).to be_nil
      expect(assigns(:user).password).to be_nil
    end

  end

  # describe "GET edit" do
  #   it "assigns the requested session as @session" do
  #     session = Session.create! valid_attributes
  #     get :edit, {:id => session.to_param}, valid_session
  #     expect(assigns(:session)).to eq(session)
  #   end
  # end

  describe "POST create" do
    describe "with valid params" do
      describe "but invalid credentials" do
        it "re-render the 'new' template" do
          post :create, {:user => invalid_credentials}
          expect(response).to render_template("new")
        end
      end
      
      describe "and valid credentials" do
        it "redirects to the reports path" do
          post :create, {:user => valid_credentials}
          expect(response).to redirect_to(reports_path)
        end
      end
    end

    describe "with invalid params" do
      it "assigns a new user as @user" do
        post :create, {:user => invalid_attributes}
        expect(assigns(:user)).not_to be_valid
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested session" do
  #       session = Session.create! valid_attributes
  #       put :update, {:id => session.to_param, :session => new_attributes}, valid_session
  #       session.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "assigns the requested session as @session" do
  #       session = Session.create! valid_attributes
  #       put :update, {:id => session.to_param, :session => valid_attributes}, valid_session
  #       expect(assigns(:session)).to eq(session)
  #     end
  #
  #     it "redirects to the session" do
  #       session = Session.create! valid_attributes
  #       put :update, {:id => session.to_param, :session => valid_attributes}, valid_session
  #       expect(response).to redirect_to(session)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns the session as @session" do
  #       session = Session.create! valid_attributes
  #       put :update, {:id => session.to_param, :session => invalid_attributes}, valid_session
  #       expect(assigns(:session)).to eq(session)
  #     end
  #
  #     it "re-renders the 'edit' template" do
  #       session = Session.create! valid_attributes
  #       put :update, {:id => session.to_param, :session => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end
  #
  # describe "DELETE destroy" do
  #   it "destroys the requested session" do
  #     session = Session.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => session.to_param}, valid_session
  #     }.to change(Session, :count).by(-1)
  #   end
  #
  #   it "redirects to the sessions list" do
  #     session = Session.create! valid_attributes
  #     delete :destroy, {:id => session.to_param}, valid_session
  #     expect(response).to redirect_to(sessions_url)
  #   end
  # end

end
