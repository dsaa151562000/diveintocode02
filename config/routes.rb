Rails.application.routes.draw do
  get 'relationships/create'

  get 'relationships/destroy'

  resources :qacomments
  resources :qas do
   resources :qacomments
  end
  
  
  resources :comments
  get 'users/index'
  get 'users/show'

  devise_for :users, controllers: { 
   sessions: "users/sessions", 
   registrations: "users/registrations", 
   passwords: "users/passwords",
   omniauth_callbacks: "users/omniauth_callbacks" 
  }
  
  resources :users, only:[:index, :show, :update] do
   member do
    get :following, :followers;    
   end
  end
  
  resources :relationships, only:[:create, :destroy]
  
  root to: "top#index"
  get 'contact/index'
  get 'contact/new'
  post 'contact/confirm'
  post 'contact/thanks'
  
  resources :blogs do
    resources :comments
  end
end
