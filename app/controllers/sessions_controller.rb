# Controlador para manejar la autenticación de usuarios (login).
class SessionsController < ApplicationController
  # Se omite la verificación CSRF para permitir login desde clientes externos.
  skip_before_filter :verify_authenticity_token

  # Acción para autenticar al usuario y devolver un token JWT si las credenciales son correctas.
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      render json: { token: token }
    else
      render json: { error: 'Credenciales inválidas' }, status: :unauthorized
    end
  end
end
