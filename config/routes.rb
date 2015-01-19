Rails.application.routes.draw do
  
  root to: "home#index"
  # get '/users/:id/conversations/new', to: 'conversations#new'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :conversations
  resources :users do
    resources :conversations, only: [:new, :create]
    resources :dogs do

    end
  end
  
end
