Evezary::Application.routes.draw do
  get 'event' => 'home#index'
  get 'story' => 'home#story'
  devise_for :users
  resources :users

  namespace :admin do
    get '/' => 'dashboard#index', ad: 'admin'
    resources :users
  end
  
  root :to => "home#index"
end