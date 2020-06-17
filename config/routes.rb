Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callback: 'omniauth_callbacks' }
  root 'pages#index'
  get 'pages/show'
end
