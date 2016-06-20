Rails.application.routes.draw do
 
  resources :projecttasks
  resources :customers
  
  resources :projects do
   resources :projecttasks
   resources :memberships
   member do
    get :membering;
    get :member_list;
   end
  end
  
  namespace :taskline do
    resources :task_comments
  end
  resources :tasks


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
   resources :tasks
   member do
    get :following, :followers;    
   end
  end
  
  namespace :taskline do
   resources :tasks do
   resources :task_comment
   post "ungoodjob"
   post "goodjob"
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
