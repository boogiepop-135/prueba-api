require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil, password: 'password')
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(email: 'test@example.com', password: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(email: 'test@example.com', password: 'password')
      user = User.new(email: 'test@example.com', password: 'password123')
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has many orders' do
      association = User.reflect_on_association(:orders)
      expect(association.macro).to eq :has_many
    end

    it 'has many products through orders' do
      association = User.reflect_on_association(:products)
      expect(association.macro).to eq :has_many
    end
  end
end