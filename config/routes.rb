Rails.application.routes.draw do
  resources :videogames
  root "users#index"

  resources :users

end
