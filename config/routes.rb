Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'profile', to: 'pages#profile'
  resources :flights

  resources :trips

  get "/profile", to: 'profile#profile'
  get "/trips", to: 'trips#index'
end
