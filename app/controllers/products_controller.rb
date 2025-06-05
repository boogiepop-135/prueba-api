# Controlador para gestionar productos de la tienda.
class ProductsController < ApplicationController
  # Todas las acciones requieren que el usuario esté autenticado.
  before_filter :authenticate_user!

  # Devuelve la lista de todos los productos.
  def index
    render json: Product.all
  end

  # Muestra los detalles de un producto específico.
  def show
    render json: Product.find(params[:id])
  end

  # Permite crear un nuevo producto.
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      # Si hay errores de validación, los devolvemos en la respuesta.
      render json: { errores: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Permite actualizar los datos de un producto existente.
  def update
    product = Product.find(params[:id])
    if product.update_attributes(product_params)
      render json: product
    else
      render json: { errores: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Permite eliminar un producto de la tienda.
  def destroy
    Product.find(params[:id]).destroy
    head :no_content
  end

  private

  # Solo permitimos los parámetros necesarios para crear o actualizar un producto.
  def product_params
    params.require(:product).permit(:name, :price)
  end
end
