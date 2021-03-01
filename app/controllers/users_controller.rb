class UsersController < ApplicationController


    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to @user
        else
            render :new
        end
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
        @user = User.find(params[:user_id])
        @videogames = Videogame.all
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
        game = Videogame.create(game_name: params[:game_name], developer: params[:developer], number_of_players: params[:number_of_players])
        user = User.find(params[:user_id])
        user.videogames << game
        redirect_to user_path(user)
    end

    private

    def user_params
        params.require(:user).permit(:username, :email_address, :steam_id)
    end

    def save_new_game_to_user_params
        params.permit(:game_id, :user_id)
    end

    def create_and_save_game_to_user_library_params
        params.permit(:user_id, :game_name, :developer, :number_of_players)
    end

end
