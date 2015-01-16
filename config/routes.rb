Rails.application.routes.draw do
  
  resources :dogs

  devise_for :users
  root to: "home#index"

  
end
