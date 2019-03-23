require 'rails_helper'

RSpec.describe 'Interests API', type: :request do
  let!(:interests) { create_list(:interest, 10) }
  let(:interest) { interests.first }
  let(:interest_id) { interest.id }
  let(:user_id) { create(:user).id }

  describe 'GET /interests' do
    before { get '/interests' }

    it 'returns active interests' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /interests/:id' do
    before { get "/interests/#{interest_id}" }

    context 'when the record exists' do
      it 'returns the interest' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(interest_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:interest_id) { 200 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Interest/)
      end
    end
  end

  describe 'POST /interests' do
    let(:valid_attributes) { { name: 'Name Test', user_id: user_id } }

    context 'when the request is valid' do
      before { post '/interests', params: valid_attributes }

      it 'creates a interest' do
        expect(json['name']).to eq('Name Test')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/interests', params: { name: 'teste' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to eq("Validation failed: User must exist")
      end
    end
  end
end
