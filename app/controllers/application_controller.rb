# Controlador base de la aplicación. Aquí se centralizan métodos comunes.
class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  # Este método verifica que el usuario esté autenticado usando JWT.
  # Si el token es válido, se asigna el usuario actual; si no, se devuelve un error.
  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    if token.blank?
      render json: { error: 'Token de autenticación faltante' }, status: :unauthorized and return
    end
    begin
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      @current_user = User.find(payload['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Token inválido' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Usuario no encontrado' }, status: :unauthorized
    end
  end
end
