Rails.application.routes.draw do
 
  devise_for :users, controllers: { sessions: 'my_sessions' }
  
  namespace :api do
    # Tus rutas existentes para los cupones
    resources :coupons, only: [:create, :index, :update, :destroy]

    # Rutas específicas para los clientes dentro del namespace 'customer'
    namespace :customer do
      # Ruta para verificar el cupón
      post 'coupons/verify', to: 'coupons#verify'

      # Rutas para las acciones sobre cupones individuales
      resources :coupons, only: [] do
        member do
          post :redeem
        end
      end
    end
  end
end
