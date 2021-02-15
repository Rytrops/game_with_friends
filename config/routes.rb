Rails.application.routes.draw do

  resources :videogames
  resources :users

  root "users#index"

end
