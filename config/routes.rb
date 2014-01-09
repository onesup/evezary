Evezary::Application.routes.draw do
  get 'event' => 'home#index'
  get 'story' => 'home#story'
  get 'download_image' => 'home#download_image'

  resources :users

  namespace :admin do
    get '/' => 'dashboard#index', ad: 'admin'
    resources :users
    resources :surveys
  end
  
  root :to => "home#index"
end