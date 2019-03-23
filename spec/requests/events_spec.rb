require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let!(:events) { create_list(:event, 10) }
  let(:event) { events.first }
  let(:event_id) { event.id }

  describe 'GET /events' do
    before { get '/events' }

    it 'returns active events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id' do
    before { get "/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the event' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 200 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'POST /events' do
    let(:valid_attributes) { { name: 'Name Test' } }

    context 'when the request is valid' do
      before { post '/events', params: valid_attributes }

      it 'creates a event' do
        expect(json['name']).to eq('Name Test')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/events', params: { name: nil } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to eq("Validation failed: Name can't be blank")
      end
    end
  end
end
