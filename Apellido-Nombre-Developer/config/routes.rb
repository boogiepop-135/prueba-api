Rails.application.routes.draw do
  # Rutas para usuarios
  resources :users, only: [:create, :update, :destroy, :index]

  # Rutas para productos
  resources :products, only: [:create, :update, :destroy, :index]

  # Rutas para órdenes
  resources :orders, only: [:create, :update, :destroy, :index]

  # Ruta para realizar una orden de compra
  post 'orders/checkout', to: 'orders#checkout'

  # Rutas para recomendaciones
  get 'recommendations', to: 'recommendations#index'
end