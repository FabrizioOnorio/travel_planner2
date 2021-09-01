Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :trips, only: [:index, :show, :new, :create] do
    resources :trip_flights, only: [:create, :new]
    resources :flights, only: [:index, :update]
  end

  get 'profile', to: 'profile#profile'
  resources :flights, only: [:create, :new, :show]
end
