class Order < ApplicationRecord
  belongs_to :user
  has_many :products

  validates :user_id, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending completed canceled] }

  def calculate_total_price
    self.total_price = products.sum(:price)
  end
end