Rails.application.routes.draw do

  root to: "home#index"
  get '/users/:user_id/conversations/:id/reply', to: 'conversations#reply', as: 'reply_to_conversation'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :conversations

<<<<<<< HEAD
  resource :profile, only: [:edit, :update, :show], controller: :users
  resources :dogs
  resources :users, only: [:index, :show]

=======
  resources :users do
    resources :conversations, only: [:new, :create]
    resources :dogs do
>>>>>>> dev_rabea

end
