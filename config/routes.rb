Rails.application.routes.draw do


  get 'sessions/new'

  get 'welcome/hello'
  root 'welcome#hello'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

   get '/users/:id/edit' => 'users#edit'
   patch '/users/:id/edit' => 'users#update'
  patch '/users/:id' => 'users#update'
  resources :users

  get '/cars/new' => 'cars#new'
  resources :cars


  resources :bookings do
    member do
      put 'pickup'
      put 'return'
      put 'cancel'
    end
  end
    patch 'bookings/:id/cancel' => 'reservations#cancel'
  post 'bookings/:id/cancel' => 'reservations#cancel'
end
