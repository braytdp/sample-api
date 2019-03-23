require 'rails_helper'

RSpec.describe 'Visits API', type: :request do
  let!(:visits) { create_list(:visit, 10) }
  let(:visit) { visits.first }
  let(:visit_id) { visit.id }

  describe 'GET /visits' do
    before { get '/visits' }

    it 'returns active visits' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /visits/:id' do
    before { get "/visits/#{visit_id}" }

    context 'when the record exists' do
      it 'returns the visit' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(visit_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:visit_id) { 200 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Visit/)
      end
    end
  end

  describe 'POST /visits' do
    let(:user_id) { create(:user).id }
    let(:event_id) { create(:event).id }
    let(:valid_attributes) { { user_id: user_id, event_id: event_id } }

    context 'when the request is valid' do
      before { post '/visits', params: valid_attributes }

      it 'creates a visit' do
        expect(json['user_id']).to eq(user_id)
        expect(json['event_id']).to eq(event_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/visits', params: { user_id: user_id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to eq("Validation failed: Event must exist, Event can't be blank")
      end
    end
  end
end
