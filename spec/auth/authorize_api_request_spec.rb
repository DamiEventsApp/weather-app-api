require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id)} }
  subject(:valid_request_object) { described_class.new(header) }
  subject(:invalid_request_object) { described_class.new({}) }

  describe '#call' do
    context 'with valid request headers' do
      it 'returns the corresponding user' do
        result = valid_request_object.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'with invalid request headers' do
      context 'when auth token is missing' do
        it 'should raise a Missing Token Error' do
          expect { invalid_request_object.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing Token')
        end
      end
    end

    context 'when the auth token is invalid' do
      subject(:invalid_request_obj) do
        described_class.new('Authorization' => token_generator(5))
      end

      it 'raises invalid token error' do
        expect { invalid_request_obj.call }
        .to raise_error(
            ExceptionHandler::InvalidToken, "Invalid Token: Couldn't find User"
          )
      end
    end

    context 'when auth token has expired' do
      let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
      subject(:request_obj) { described_class.new(header) }

      it 'raises ExceptionHandler::ExpiredSignature error' do
        expect { request_obj.call }
          .to raise_error(
            ExceptionHandler::InvalidToken,
            /Signature has expired/
          )
      end
    end

    context 'when auth token is fake' do
      let(:header) { { 'Authorization' => 'ANotSoRealToken' } }
      subject(:invalid_request_obj) { described_class.new(header) }

      it 'handles JWT::DecodeError' do
        expect { invalid_request_obj.call }
          .to raise_error(
            ExceptionHandler::InvalidToken,
            /Not enough or too many segments/
          )
      end
    end
  end
end