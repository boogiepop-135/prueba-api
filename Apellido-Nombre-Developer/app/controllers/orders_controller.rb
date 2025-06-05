class OrdersController < ApplicationController
  before_action :authenticate_user!

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # POST /orders
  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:id
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/:id
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    head :no_content
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :quantity, :total_price)
  end
end