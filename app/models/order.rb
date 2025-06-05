# Modelo para las órdenes de compra realizadas por los usuarios.
class Order < ActiveRecord::Base
  # Cada orden pertenece a un usuario.
  belongs_to :user

  # Una orden puede tener varios productos a través de order_items.
  has_many :order_items
  has_many :products, through: :order_items

  # Serialización para mostrar la orden junto con los productos asociados.
  def as_json(options = {})
    super(only: [:id, :user_id, :created_at], include: { products: { only: [:id, :name, :price] } })
  end
end
