# Controlador para gestionar usuarios (registro, consulta, actualización y eliminación).
class UsersController < ApplicationController
  # Solo se permite crear usuario sin autenticación; el resto requiere estar logueado.
  before_filter :authenticate_user!, except: [:create]

  # Devuelve los datos del usuario autenticado.
  def show
    user = User.find(params[:id])
    if user.id != @current_user.id
      render json: { error: "No autorizado" }, status: :unauthorized and return
    end
    render json: user
  end

  # Permite registrar un nuevo usuario.
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errores: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Permite que el usuario autenticado actualice su información.
  def update
    user = User.find(params[:id])
    if user.id != @current_user.id
      render json: { error: "No autorizado" }, status: :unauthorized and return
    end
    if user.update_attributes(user_params)
      render json: user
    else
      render json: { errores: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Permite que el usuario autenticado elimine su cuenta.
  def destroy
    user = User.find(params[:id])
    if user.id != @current_user.id
      render json: { error: "No autorizado" }, status: :unauthorized and return
    end
    user.destroy
    head :no_content
  end

  private

  # Solo se permiten estos parámetros para crear/actualizar usuario.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
