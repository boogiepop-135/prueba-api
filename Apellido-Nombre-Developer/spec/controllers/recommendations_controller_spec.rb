require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns recommended products for the user' do
      # Assuming the recommendation logic is implemented
      get :index
      expect(JSON.parse(response.body)).to include('recommended_products')
    end
  end

  describe 'POST #create' do
    it 'creates a new recommendation' do
      post :create, params: { product_id: product.id }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('message' => 'Recommendation created successfully')
    end

    it 'returns an error if product does not exist' do
      post :create, params: { product_id: nil }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include('error' => 'Product not found')
    end
  end
end