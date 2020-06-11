Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  resources :users, except: [:new,:destroy] do
    member do
      get :followings
      get :followers
      get :likeings
      get :games
    end
  end
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :posts, only: [:index,:show,:new,:create,:destroy] do
    member do
      get :followings
    end
  end
  resources :comments, only: [:create,:destroy]

  resources :games do
    get :search, on: :collection
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create,:destroy]
  
end
