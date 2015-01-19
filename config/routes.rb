Rails.application.routes.draw do

  root to: "home#index"
  get '/users/:user_id/conversations/:id/reply', to: 'conversations#reply'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :conversations

  resources :users do
    resources :conversations, only: [:new, :create]
    resources :dogs do

    end
  end
  
end
