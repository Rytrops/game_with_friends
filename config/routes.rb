Rails.application.routes.draw do
  root "home#home"

  namespace :api do
    namespace :v1 do
      devise_for :users, :skip => [:sessions], controllers: {registrations: 'api/v1/users/registrations'} do
        devise_scope :user do
            get '/users/sign_out', to: 'devise/sessions#destroy'
        end
      end

      post '/users/sign-in', to: 'authentication#create'

      resources :videogames
      resources :users, except: [:new, :create] do 
          get 'add_game', to: 'users#add_new_game'
          post 'save_game', to: "users#save_new_game_to_user" 
          post 'remove_game', to: "users#remove_game_from_user_library"
          post 'create_and_save_game', to: 'users#create_and_save_game_to_user_library'
          post 'connect_steam_account', to: 'users#link_steam_account_to_user'
      end
    end
  # end
  end
  get '*path', to: 'home#home', via: :all
end