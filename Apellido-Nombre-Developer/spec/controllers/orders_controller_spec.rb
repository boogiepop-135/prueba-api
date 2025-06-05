require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { product_id: create(:product).id, quantity: 2 } }
  let(:invalid_attributes) { { product_id: nil, quantity: 0 } }

  before do
    request.headers['Authorization'] = "Bearer #{user.generate_jwt}" # Assuming a method to generate JWT
  end

  describe 'GET #index' do
    it 'returns a success response' do
      order = Order.create! valid_attributes
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to include(JSON.parse(order.to_json))
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Order' do
        expect {
          post :create, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end

      it 'renders a JSON response with the new order' do
        post :create, params: { order: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('id')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new order' do
        post :create, params: { order: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end

  describe 'PATCH #update' do
    let!(:order) { Order.create! valid_attributes }

    context 'with valid params' do
      let(:new_attributes) { { quantity: 3 } }

      it 'updates the requested order' do
        patch :update, params: { id: order.id, order: new_attributes }
        order.reload
        expect(order.quantity).to eq(3)
      end

      it 'renders a JSON response with the order' do
        patch :update, params: { id: order.id, order: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('quantity' => 3)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the order' do
        patch :update, params: { id: order.id, order: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:order) { Order.create! valid_attributes }

    it 'destroys the requested order' do
      expect {
        delete :destroy, params: { id: order.id }
      }.to change(Order, :count).by(-1)
    end

    it 'renders a JSON response with no content' do
      delete :destroy, params: { id: order.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end