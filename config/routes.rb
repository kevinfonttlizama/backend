Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'my_sessions' }
  
  namespace :api do
    # Rutas para los cupones (a nivel general)
    resources :coupons, only: [:create, :index, :update, :destroy]

    namespace :customer do
      # Ruta para verificar el cupón (sin requerir autenticación por Devise)
      post 'coupons/verify', to: 'coupons#verify'

      # Rutas para las acciones sobre cupones individuales
      resources :coupons, only: [] do
        member do
          post :redeem  # Esta acción sí requiere autenticación
        end
      end
    end
  end
end
