# Definición de rutas RESTful para usuarios, productos y órdenes.
# Incluye ruta personalizada para login y para realizar checkout de órdenes.
PruebaApi::Application.routes.draw do
  resources :users
  resources :products
  resources :orders do
    post 'checkout', on: :collection
  end
  post 'login', to: 'sessions#create'
end
