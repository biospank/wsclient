require 'rails_helper'

RSpec.describe Api::WorkShare::V1::Session, :type => :lib do
  describe "class methods" do
    it "respond to 'restore'" do
      expect(Api::WorkShare::V1::Session).to respond_to(:restore)
    end
  end
  
  describe "restore" do
    let(:valid_session) {
      build(:wsession)
    }

    it "return an instance of an authorized Api::WorkShare::V1::Session" do
      valid_session.authorize
      serialized_session = valid_session.dump
      new_session = Api::WorkShare::V1::Session.restore(serialized_session)
      expect(new_session).to be_an_instance_of(Api::WorkShare::V1::Session)
      expect(new_session).to be_authorized
    end
    
  end

  describe "new" do
    it "create a new session" do
      key = 'test_key'
      secret = 'test_secret'
      
      expect(Api::WorkShare::V1::Session).to receive(:new).once.with(key, secret)
      
      Api::WorkShare::V1::Session.new(key, secret)
    end
    
  end
  
  describe "authorize" do
    describe "with valid credentials" do
      let(:valid_session) {
        build(:wsession)
      }

      it "to be authorized" do
        expect(valid_session.authorize).to be true 
        expect(valid_session.authorized?).to be true
      end
    end

    describe "with invalid credentials" do
      let(:invalid_session) {
        build(:wsession, key: 'key', secret: 'secret')
      }

      it "raise error" do
        expect {
          invalid_session.authorize
        }.to raise_error(Api::Errors::AuthorizationError)
				
        expect(invalid_session.authorized?).to be false
      end
    end
  end
  
  describe "all_files" do
    describe "with a restored session" do 
      let(:valid_session) {
        build(:wsession)
      }

      it "return an array of files metadata" do
				valid_session.authorize
				serialized_session = valid_session.dump
				session = Api::WorkShare::V1::Session.restore(serialized_session)
				expect(valid_session.all_files).to be_an(Array)
      end
    end    

    describe "with invalid credentials" do
      let(:invalid_session) {
        build(:wsession, key: 'key', secret: 'secret')
      }

      it "raise error" do
        expect {
          invalid_session.authorize
        }.to raise_error(Api::Errors::AuthorizationError)
				
        expect {
          invalid_session.all_files
        }.to raise_error(Api::Errors::AuthorizationError)
      end
    end
  end
  
end
