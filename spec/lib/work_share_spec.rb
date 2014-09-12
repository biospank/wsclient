require 'rails_helper'

RSpec.describe Api::WorkShare::V1::Session, :type => :lib do
  describe "class methods" do
    it "respond to 'restore'" do
      expect(Api::WorkShare::V1::Session).to respond_to(:restore)
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

      it "return true" do
        expect(valid_session.authorized?).to be false
        expect(valid_session.authorize).to be true 
        expect(valid_session.authorized?).to be true
      end
    end

    describe "with invalid credentials" do
      let(:invalid_session) {
        build(:wsession, key: 'key', secret: 'secret')
      }

      it "return false" do
        expect(invalid_session.authorized?).to be false
        expect(invalid_session.authorize).to be false 
        expect(invalid_session.authorized?).to be false
      end
    end
  end
  
  describe "restore" do
    it "return an instance of Api::WorkShare::V1::Session" do
      serialized_session = {:consumer_key => 'key', :consumer_password => 'secret'}.to_yaml
      session = Api::WorkShare::V1::Session.restore(serialized_session)
      expect(session).to be_an_instance_of(Api::WorkShare::V1::Session)
    end
    
    it "return an authenticated session" do
      
    end
  end
end
