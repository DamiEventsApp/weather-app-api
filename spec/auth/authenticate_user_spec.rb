require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_request_object) { described_class.new(user.email, user.password) }

  context 'with valid credentials' do
    it 'should return a valid user object' do
      result = valid_request_object.call
      expect(result[:user])
        .to eq(user)
    end
  end
end 