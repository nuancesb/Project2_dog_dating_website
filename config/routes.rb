Rails.application.routes.draw do
  
  root to: "home#index"

  resources :dogs

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  
end
