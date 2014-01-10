Evezary::Application.routes.draw do
  devise_for :users
  resources :users

  namespace :admin do
    get '/' => 'dashboard#index', ad: 'admin'
    resources :users
    resources :surveys
  end
  get 'event' => 'home#index'
  get 'story' => 'home#story'
  get 'download_image' => 'home#download_image'
  get "logout"  => "devise/sessions#destroy", :as => "logout"
  get 'is_surveyed' => 'users#is_surveyed'
  get '/:id', to: 'users#tracking_log'
  root :to => "home#index"
end