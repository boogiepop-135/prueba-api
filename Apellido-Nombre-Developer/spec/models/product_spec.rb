require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = Product.new(name: 'Sample Product', price: 10.0, stock: 100)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(name: nil, price: 10.0, stock: 100)
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product = Product.new(name: 'Sample Product', price: nil, stock: 100)
      expect(product).to_not be_valid
    end

    it 'is not valid with a negative price' do
      product = Product.new(name: 'Sample Product', price: -1.0, stock: 100)
      expect(product).to_not be_valid
    end

    it 'is not valid without stock' do
      product = Product.new(name: 'Sample Product', price: 10.0, stock: nil)
      expect(product).to_not be_valid
    end

    it 'is not valid with negative stock' do
      product = Product.new(name: 'Sample Product', price: 10.0, stock: -1)
      expect(product).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has many orders' do
      association = Product.reflect_on_association(:orders)
      expect(association.macro).to eq :has_many
    end
  end
end