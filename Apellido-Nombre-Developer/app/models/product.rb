class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :orders_products
  has_many :orders, through: :orders_products

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end