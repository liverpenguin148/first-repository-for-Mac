Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callback: 'omniauth_callbacks' }
  root 'pages#index'
  get 'pages/show'
  resources :tasks, only: [:create, :update, :destroy]
end
