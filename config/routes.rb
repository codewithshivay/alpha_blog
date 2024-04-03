Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/about', to: 'pages#about'
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :articles
  get 'signup', to: 'users#new'
  #post 'users', to: 'users#create'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/search', to: 'articles#search'
  get '/search', to: 'users#search'

  resources :users do
    member do
      get 'edit_password', to: 'passwords#edit_password'
      patch 'update_password', to: 'passwords#update_password'
    end
  end
  
  resources :passwords, only: [:new, :create] do
    collection do
      get 'enter_otp'
      post 'verify_otp'
      get 'reset_password'
    end
  end

  resources :categories, except: [:destroy]

end
