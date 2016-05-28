Rails.application.routes.draw do
  resources :qas
  resources :comments
  get 'users/index'
  get 'users/show'

  devise_for :users, controllers: { 
   sessions: "users/sessions", 
   registrations: "users/registrations", 
   passwords: "users/passwords",
   omniauth_callbacks: "users/omniauth_callbacks" 
  }

  root to: "top#index"
  get 'contact/index'
  get 'contact/new'
  post 'contact/confirm'
  post 'contact/thanks'
  
  resources :blogs do
    resources :comments
  end
end
