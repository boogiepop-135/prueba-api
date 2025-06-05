class ApplicationController < ActionController::API
  include ActionController::Helpers

  before_action :authenticate_user!

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JwtAuth.decode(token) if token
    @current_user = User.find(decoded_token[:user_id]) if decoded_token
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  attr_reader :current_user
