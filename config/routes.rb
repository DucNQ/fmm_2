Fmm2::Application.routes.draw do
  resources :sessions,  only: [:new, :create, :destroy]
  resources :users, only: [:show, :edit, :update]
  resources :teams, only: [:show, :index]

  namespace :admin do
    resources :users
    resources :positions
    resources :projects
    resources :skills
  end

  resources :teams do
    resources :users
  end
  
  root  'static_pages#home'

  match '/signin',  to: 'sessions#new',               via: 'get'
  match '/signout', to: 'sessions#destroy',           via: 'delete'
end
