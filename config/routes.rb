# config/routes.rb

Rails.application.routes.draw do
 
  devise_for :users, controllers: { sessions: 'my_sessions' }
  namespace :api do
    resources :coupons, only: [:create, :index, :update, :destroy]
  end
end
