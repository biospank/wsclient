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

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a(User)
      expect(assigns(:user).username).to be_nil
      expect(assigns(:user).password).to be_nil
    end

  end

  describe "POST create" do
    describe "with valid params" do
      describe "but invalid credentials" do
        it "re-render the 'new' template" do
          post :create, {:user => invalid_credentials}
          expect(response).to render_template("new")
        end
      end
      
      describe "and valid credentials" do
        it "redirects to reports path" do
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

end
