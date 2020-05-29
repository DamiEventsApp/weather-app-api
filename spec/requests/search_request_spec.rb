require 'rails_helper'

RSpec.describe 'Search API', type: :request do
  describe 'POST /search_events' do
    # create test user
    let!(:user) { create(:user) }
    let!(:events) { create_list(:event, 10) }

    # returns auth token and user object when request is valid
    context 'result exists' do
      context 'when search term is provided' do
        before do
          params = attributes_for(:event)
          params[:title] = "boyboyboyboyboy"
          user.events.create!(params) 
          get "/search_events", {params: {term: "boyboyboyboyboy"}, headers: valid_request_header}
        end

        it 'should search by title or location' do
          expect(json['events'].size).to eq(1)
        end

        it 'should have status 200' do
          expect(response).to have_http_status(200)
        end
      end
      
      context 'when search date is provided' do
        before do
          params = attributes_for(:event)
          params[:date] =  4.days.ago.to_i 
          user.events.create!(params) 
          get "/search_events", {params: {date: 4.days.ago.to_i}, headers: valid_request_header} 
        end

        it 'should search by date alone' do
          expect(json['events'].size).to eq(1)
        end

        it 'should have status 200' do
          expect(response).to have_http_status(200)
        end
      end
    end

    # handles invalid credentials
    context 'when there are no results' do
      before { get "/search_events", params: {term: "nullnullnull"}, headers: valid_request_header }

      it 'it returns no results' do
        expect(json['events']).to be_empty
      end
    end

    context 'when there is no search term or date provided' do
      before { get "/search_events", params: {}, headers: valid_request_header }

      it 'should raise a missing parameter error' do
        expect(response.body).to match(/Parameter Error: Missing search term or date/)
      end
    end
  end
end 