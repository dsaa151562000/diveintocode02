Rails.application.routes.draw do
 
  #get 'notifications/index'

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
   resources :tasks
   resources :notifications, only: [:index]
   member do
    get :following, :followers;    
   end
   
   resources :submit_requests , shallow: true do
    get 'approve'
    get 'unapprove'
    get 'reject'
     collection do
      get 'inbox'
     end
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
  
  resources :conversations do
   resources :messages
  end
  

  

end
