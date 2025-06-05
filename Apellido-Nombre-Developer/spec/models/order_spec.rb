require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create(name: 'Test Product', price: 100.0) }
  let(:order) { Order.new(user: user, product: product, quantity: 2) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(order).to be_valid
    end

    it 'is not valid without a user' do
      order.user = nil
      expect(order).to_not be_valid
    end

    it 'is not valid without a product' do
      order.product = nil
      expect(order).to_not be_valid
    end

    it 'is not valid without a quantity' do
      order.quantity = nil
      expect(order).to_not be_valid
    end

    it 'is not valid with a quantity less than 1' do
      order.quantity = 0
      expect(order).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(order.user).to eq(user)
    end

    it 'belongs to a product' do
      expect(order.product).to eq(product)
    end
  end

  describe 'total_price' do
    it 'calculates the total price of the order' do
      expect(order.total_price).to eq(200.0)
    end
  end
end