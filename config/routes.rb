Rails.application.routes.draw do


  root to: 'static_pages#home'
  get 'static_pages/home'
#  get 'static_pages/help'
  get 'static_pages/about'

  match '/help' , to: 'static_pages#help' , via: 'get'
  match '/signup' , to: 'users#new' , via: 'get'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
