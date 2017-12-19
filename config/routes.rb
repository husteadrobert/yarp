Rails.application.routes.draw do

  get 'ui(/:action)', controller: 'ui'

  root to: 'pages#front'
  get 'home', to: 'pages#home'

  resources :businesses, except: [:destroy, :edit, :update] do
    resources :reviews, only: [:create]
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  resources :users, only: [:create, :show]

end
