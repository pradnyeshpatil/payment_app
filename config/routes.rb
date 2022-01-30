Rails.application.routes.draw do
  
  devise_for :views
  devise_for :users
  root to: 'static_pages#home'
  post 'user/create', to: 'users#create'
  resources :users do
    resources :wallets
  end
  resources :payment_transactions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
