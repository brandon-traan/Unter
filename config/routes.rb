Rails.application.routes.draw do
  

  get 'welcome/hello'

  root 'welcome#hello'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end