Evezary::Application.routes.draw do
  resources :users do
  end 
  root :to => "home#index"
end