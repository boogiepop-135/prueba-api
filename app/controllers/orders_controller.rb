# Controlador para gestionar las órdenes de compra de los usuarios.
class OrdersController < ApplicationController
  # Todas las acciones requieren autenticación.
  before_filter :authenticate_user!

  # Devuelve todas las órdenes del usuario autenticado.
  def index
    render json: @current_user.orders
  end

  # Muestra una orden específica del usuario autenticado.
  def show
    order = @current_user.orders.find_by(id: params[:id])
    if order.nil?
      render json: { error: "No autorizado o no existe la orden" }, status: :unauthorized and return
    end
    render json: order
  end

  # Permite crear una nueva orden (no se usa directamente, se recomienda usar checkout).
  def create
    order = @current_user.orders.build
    if order.save
      render json: order, status: :created
    else
      render json: { errores: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Permite actualizar una orden (no es común en e-commerce, pero se deja por si se requiere).
  def update
    order = @current_user.orders.find_by(id: params[:id])
    if order.nil?
      render json: { error: "No autorizado o no existe la orden" }, status: :unauthorized and return
    end
    if order.update_attributes(params[:order])
      render json: order
    else
      render json: { errores: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Permite eliminar una orden del usuario autenticado.
  def destroy
    order = @current_user.orders.find_by(id: params[:id])
    if order.nil?
      render json: { error: "No autorizado o no existe la orden" }, status: :unauthorized and return
    end
    order.destroy
    head :no_content
  end

  # Endpoint para realizar una compra: crea una orden y asocia los productos seleccionados.
  def checkout
    product_ids = params[:products] || []
    if product_ids.empty?
      render json: { error: "Debe seleccionar al menos un producto" }, status: :unprocessable_entity and return
    end
    products = Product.where(id: product_ids)
    if products.count != product_ids.size
      render json: { error: "Uno o más productos no existen" }, status: :unprocessable_entity and return
    end
    order = @current_user.orders.create
    products.each do |product|
      order.order_items.create(product_id: product.id)
    end
    render json: order, status: :created
  end
end
