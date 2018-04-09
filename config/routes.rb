Rails.application.routes.draw do
  get 'welcome/hello'

  root 'welcome#hello'
end