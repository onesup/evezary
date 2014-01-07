Evezary::Application.routes.draw do
  get 'event' => 'home#index'
  get 'story' => 'home#story'
  resources :users
  root :to => "home#index"
end