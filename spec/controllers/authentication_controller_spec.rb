require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { create(:user) }

    # set valid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }
    end

    # setinvalid credentials
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                     

    # returns auth token and user object when request is valid
    context 'When request is valid' do
      before { post 'login', params: valid_credentials }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end

      it 'returns a valid user object' do
        expect(json['user']).not_to be_nil
      end
    end

    # handles invalid credentials
    context 'When request is invalid' do
      before { post 'login', params: invalid_credentials }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid Credentials/)
      end
    end
  end
end 