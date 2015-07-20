Rails.application.routes.draw do

  root :to => 'static_pages#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
  resources :schools
  resources :roles
  resources :tests
end
