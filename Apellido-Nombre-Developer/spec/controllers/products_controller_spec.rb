require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }
  let(:valid_attributes) { { name: 'New Product', price: 10.0 } }
  let(:invalid_attributes) { { name: '', price: -1 } }

  before do
    request.headers['Authorization'] = "Bearer #{user.generate_jwt}"
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to be_an(Array)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Product' do
        expect {
          post :create, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested product' do
        patch :update, params: { id: product.id, product: { name: 'Updated Product' } }
        product.reload
        expect(product.name).to eq('Updated Product')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not update the product' do
        patch :update, params: { id: product.id, product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      product_to_delete = create(:product)
      expect {
        delete :destroy, params: { id: product_to_delete.id }
      }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end