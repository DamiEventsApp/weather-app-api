require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_request_object) { described_class.new(user.email, user.password) }
  subject(:invalid_request_object) { described_class.new("wrong@email.com", "wrongpassword") }

  context 'with valid credentials' do
    it 'should return a valid user object' do
      result = valid_request_object.call
      expect(result[:user].size).to eq(3)
    end
  end

  context 'with invalid credentials' do
    it 'should raise authentication error' do
      result = 
      expect { invalid_request_object.call }
        .to raise_error(
          ExceptionHandler::AuthenticationError, "Invalid Credentials"
        )
    end
  end
end 