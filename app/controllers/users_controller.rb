class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user_to_edit_library, only: [:add_new_game, :remove_game_from_user_library]
    before_action :correct_user_to_edit_profile, only: [:edit, :update, :destroy]
    
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @looking_at_self = is_current_user?(@user)
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        if @user.update(user_params)
          redirect_to @user
        else
          render :edit
        end
    end

    def destroy
        @user = current_user
        @user.destroy
        redirect_to root_path
    end

    def add_new_game
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

    def link_steam_account_to_user
        
    end

    #should these be private methods?
    def correct_user_to_edit_library
        user_library_to_edit = User.find(params[:user_id])
        redirect_to user_path(user), notice: "Not Authorized to Edit This Profile" if !is_current_user?(user_library_to_edit) 
    end

    def correct_user_to_edit_profile
        user_profile_to_edit = User.find(params[:id])
        redirect_to user_path(user), notice: "Not Authorized to Edit This Profile" if !is_current_user?(user_profile_to_edit)
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

    def is_current_user?(user)
        current_user == user
    end
end
