class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index]

    def index
        @users = User.all
    end

    

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
    
        if @user.update(user_params)
          redirect_to @user
        else
          render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_path
    end

    def add_new_game
        # @user = User.find(params[:user_id])
        @user = current_user
        @videogames = Videogame.all
        @videogame = Videogame.new
    end

    def save_new_game_to_user
        user = User.find(save_new_game_to_user_params[:user_id])
        game = Videogame.find(save_new_game_to_user_params[:game_id])
        user.videogames << game

        redirect_to user_path(user)
    end

    def remove_game_from_user_library
        user = User.find(save_new_game_to_user_params[:user_id])
        game = Videogame.find(save_new_game_to_user_params[:game_id])
        user.videogames.delete(game)

        redirect_to user_path(user)
    end

    def create_and_save_game_to_user_library
        params = create_and_save_game_to_user_library_params
        videogame = Videogame.new(game_name: params[:game_name], developer: params[:developer], number_of_players: params[:number_of_players])
        user = User.find(params[:user_id])
        
        if videogame.save
            user.videogames << videogame
            redirect_to user_path(user)
        else
            @videogames = Videogame.all
            @user = user
            @videogame = videogame
            render :add_new_game
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :steam_id, :password)
    end

    def save_new_game_to_user_params
        params.permit(:game_id, :user_id)
    end

    def create_and_save_game_to_user_library_params
        params.permit(:user_id, :game_name, :developer, :number_of_players)
    end
end
