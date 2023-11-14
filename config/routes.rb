# config/routes.rb

Rails.application.routes.draw do
 
  devise_for :users, controllers: { sessions: 'my_sessions' }
  
  namespace :api do
    # Tus rutas existentes para los cupones
    resources :coupons, only: [:create, :index, :update, :destroy]

    # Aquí se agregan las nuevas rutas específicas para los clientes
    namespace :customer do
      # Ruta para verificar el cupón
      post 'coupons/verify', to: 'coupons#verify'

      # Ruta para canjear el cupón
      post 'coupons/:id/redeem', to: 'coupons#redeem'
    end
  end
end
