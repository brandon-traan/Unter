Rails.application.routes.draw do
  get  '/signup',  to: 'users#new'

  get 'welcome/hello'

  root 'welcome#hello'
end