Rails.application.routes.draw do

  resources :reviews
  resources :videogames
  resources :users do 
    get 'add_game', to: 'users#add_new_game'
    post 'save_game', to: "users#save_new_game_to_user" 
    post 'remove_game', to: "users#remove_game_from_user_library"
    post 'create_and_save_game', to: 'users#create_and_save_game_to_user_library'
  end

  root "users#index"

end
