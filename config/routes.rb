Rails.application.routes.draw do

  root to: "home#index"
  #get '/users/:user_id/conversations/:id/reply', to: 'conversations#reply', as: 'reply_to_conversation'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :conversations, only: [:index, :show, :destroy] do
       member do
        post 'reply'
      end 
    end

  resource :profile, only: [:edit, :update, :show], controller: :users
  resources :dogs

  resources :users, only: [:index, :show] do
    resources :conversations, only: [:new, :create] do
      
    end
  end

end
