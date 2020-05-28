require 'rails_helper'

RSpec.describe "Events API", type: :request do
  let!(:events) { create_list(:event, 15)}
  let!(:event) { events.first}
  let(:user) { event.user }

  describe 'GET /events do' do
    before { get '/events' }

    it 'should return the first 15 events' do
      expect(json["events"].size).to eq(15)
    end

    it 'should return pagination controls' do
      expect(json['meta']).not_to be_empty
    end
  end

  describe 'PUT /events/:id do' do
    context "when the record exists" do
      before { put "/events/#{event.id}", params: {event: attributes_for(:event)}, headers: valid_request_header }

      it 'it should return status of 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record is invalid' do
      before { put "/events/#{500}", params: {event: attributes_for(:event)}, headers: valid_request_header }

      it 'should raise an exception' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end

  end

  describe 'DELETE /events/:id do' do
    
    context "when the record exists" do
      before { delete "/events/#{event.id}", headers: valid_request_header }

      it 'it should return status of 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record is invalid' do
      before { delete "/events/#{500}", headers: valid_request_header }

      it 'should raise an exception' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end

  end

  describe 'POST /events do' do
    
    context "with valid parameters" do
      before { post "/events/", params: {event: attributes_for(:event)}, headers: valid_request_header }

      it 'it should return status of 200' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      before { post "/events", params: {event: { title: "Some title" }}, headers: valid_request_header }

      it 'should raise an exception' do
        expect(response.body).to match(/Validation failed: Date can't be blank/)
      end

      it 'should raise an exception' do
        expect(response).to have_http_status(422)
      end
    end

  end
end 