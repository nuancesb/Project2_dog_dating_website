Rails.application.routes.draw do
  
  root to: "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resource :profile, only: [:edit, :update, :show], controller: :users
  resources :dogs
  resources :users, only: [:index, :show]


end
