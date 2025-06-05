class User < ApplicationRecord
  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  # Associations
  has_many :orders
  has_many :products, through: :orders

  # Methods for JWT authentication can be added here
end