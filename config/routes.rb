Rails.application.routes.draw do
  

  get 'sessions/new'

  get 'welcome/hello'
  root 'welcome#hello'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :cars
  resources :bookings do
    member do
      put 'pickup'
      put 'return'
      put 'cancel'
    end
  end
end