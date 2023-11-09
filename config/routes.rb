# config/routes.rb

Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  get 'admin/dashboard', to: 'admin#dashboard', as: :admin_dashboard
  get 'customer/dashboard', to: 'customer#dashboard', as: :customer_dashboard
end
