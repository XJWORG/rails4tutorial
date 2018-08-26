Rails.application.routes.draw do


  root to: 'static_pages#home'
  resources :sessions , only: [:new , :create , :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get 'static_pages/home'
#  get 'static_pages/help'
  get 'static_pages/about'

  match '/help' ,   to: 'static_pages#help' , via: 'get'
  match '/signup' , to: 'users#new'         , via: 'get'

  match '/signin' , to: 'sessions#new'      , via: 'get'
  match '/signout', to: 'sessions#destroy'  , via: 'delete'


  resources :users do
    member do
      get :following, :followers
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
