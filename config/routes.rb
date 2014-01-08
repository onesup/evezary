Evezary::Application.routes.draw do
  get 'event' => 'home#index'
  get 'story' => 'home#story'

  resources :users

  namespace :admin do
    get '/' => 'dashboard#index', ad: 'admin'
    resources :users
  end
  
  root :to => "home#index"
end