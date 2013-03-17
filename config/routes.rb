Chayote::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "users/sessions" }


  root :to => "home#index"
  
  namespace :admin do
    resources :members
    resources :projects
    resources :users
    match 'projects/:id/add_user' => "projects#add_user"
    match 'projects/:id/remove_user' => "projects#remove_user"
  end
  resources :projects do
    resources :tasks
    resource :snapshots
  end
  resources :tasks do
    resources :time_entries
  end
  resources :time_entries
  resources :snapshots, :only => [:show]

  get 'invoice/new' => "invoice#new", :as => :new_invoice
  post 'invoice/show' => "invoice#show", :as => :invoice

  match 'bot' => "bot#index"
end
