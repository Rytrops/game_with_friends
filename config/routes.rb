Rails.application.routes.draw do

  resources :videogames
  resources :users do 
    get 'add_game', to: 'users#add_new_game'
    post 'save_game', to: "users#save_new_game_to_user" 
  end

  root "users#index"

end
