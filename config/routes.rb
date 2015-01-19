Rails.application.routes.draw do
  
  root to: "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :conversations
  resources :users do
    resources :dogs do

    end
  end
  
end
