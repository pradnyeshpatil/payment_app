Rails.application.routes.draw do
  
  devise_for :users, skip: [:registrations]
  root to: 'wallets#show'

  devise_scope :user do
    devise_for :users, path: '/users', class_name: 'User', only: %i[registrations], controllers: { registrations: 'users' }
    get 'users/:id', action: 'show', controller: 'users', as: 'user'
    get 'users/:id/edit', action: 'edit', controller: 'users', as: 'edit_user'
    get 'users', action: 'index', controller: 'users', as: 'users'
    put 'users/:id', action: 'update', controller: 'users', as: 'update_user'
  end

  resources :users do
    resources :wallets
  end

  resources :payment_transactions
  get '/generate_report' => 'payment_transactions#generate_report', as: :generate_report
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
