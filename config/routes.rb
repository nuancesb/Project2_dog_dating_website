Rails.application.routes.draw do

  root to: "home#index"
  #get '/users/:user_id/conversations/:id/reply', to: 'conversations#reply', as: 'reply_to_conversation'


  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  get  '/home/faq', to: "home#faq", as: 'faq'
  get  '/home/about', to: "home#about", as: 'about'
  resources :conversations, only: [:index, :show, :destroy] do
       member do
        post 'reply'
        post 'trash'
        post 'untrash'
      end 
    end

  resource :profile, only: [:edit, :update, :show], controller: :users
  
  resources :dogs

  resources :users, only: [:index, :show] do
    member do
      post "like", to: "dogs#like"
      post "unlike", to: "dogs#unlike"
    end
    resources :conversations, only: [:new, :create] do
      
    end
  end

end
