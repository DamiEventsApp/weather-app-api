require 'rails_helper'

RSpec.describe 'Search API', type: :request do
  describe 'POST /search_events' do
    # create test user
    let!(:user) { create(:user) }
    let(:event) { create(:event) }
    let(:title) { event.title }

    # returns auth token and user object when request is valid
    context 'result exists' do
      before { get "/search_events", params: {search_term: title}, headers: valid_request_header }
      
      it 'returns the results' do
        expect(json['events']).not_to be_empty
      end

      it 'should have status 200' do
        expect(response).to have_http_status(200)
      end
    end

    # handles invalid credentials
    context 'when there are no results' do
      before { get "/search_events", params: {search_term: "nullnullnull"}, headers: valid_request_header }

      it 'it returns no results' do
        expect(json['events']).to be_empty
      end
    end
  end
end 