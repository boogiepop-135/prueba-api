class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  # GET /recommendations
  def index
    @recommendations = recommend_products(current_user)
    render json: @recommendations
  end

  private

  def recommend_products(user)
    # Lógica simple de recomendación basada en compras anteriores
    purchased_product_ids = user.orders.includes(:products).map(&:product_ids).flatten.uniq
    Product.where.not(id: purchased_product_ids).sample(5) # Recomendar 5 productos no comprados
  end
end