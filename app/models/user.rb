# Modelo que representa a los usuarios registrados en la plataforma.
class User < ActiveRecord::Base
  # Permite el manejo seguro de contraseñas (hash y autenticación).
  has_secure_password

  # Relación: un usuario puede tener muchas órdenes.
  has_many :orders

  # Validaciones para asegurar datos consistentes.
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "debe ser un email válido" }
  validates :password, presence: true, length: { minimum: 6, message: "debe tener al menos 6 caracteres" }, on: :create

  # Solo exponemos los campos necesarios al serializar el usuario.
  def as_json(options = {})
    super(only: [:id, :email, :created_at])
  end
end
