Chayote::Application.routes.draw do
  devise_for :users

  root :to => "home#index"
  
  namespace :admin do
    resources :members
    resources :projects
    match 'projects/:id/add_user' => "projects#add_user"
    match 'projects/:id/remove_user' => "projects#remove_user"
  end
  resources :projects do
    resources :tasks
  end
  resources :tasks do
    resources :time_entries
  end
  resources :time_entries
end
