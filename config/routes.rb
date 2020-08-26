Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:create]
  #Create Static Controller
  #Create function called Home
  root to: "static#home"

end
