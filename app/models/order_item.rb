# Modelo que representa la relación entre una orden y un producto.
class OrderItem < ActiveRecord::Base
  # Cada ítem pertenece a una orden y a un producto específico.
  belongs_to :order
  belongs_to :product
end
