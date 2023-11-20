# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'my_sessions' }
  
  namespace :api do
    resources :coupons, only: [:index, :show, :create, :update, :destroy]
    resources :items, only: [:index]
    namespace :customer do
      post 'coupons/verify', to: 'coupons#verify'
      resources :coupons, only: [] do
        member do
          post :redeem
        end
      end
    end
    post '/purchases', to: 'purchases#create'
  end
end
