# Modelo para los productos disponibles en la tienda.
class Product < ActiveRecord::Base
  # Un producto puede estar en muchos ítems de orden.
  has_many :order_items

  # Validaciones para evitar productos duplicados y asegurar precios válidos.
  validates :name, presence: { message: "es obligatorio" }, uniqueness: { message: "ya existe" }
  validates :price, presence: { message: "es obligatorio" }, numericality: { greater_than: 0, message: "debe ser mayor a 0" }

  # Serialización personalizada para exponer solo los datos relevantes.
  def as_json(options = {})
    super(only: [:id, :name, :price, :created_at])
  end
end
