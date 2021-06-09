module Api
  module V1
    class UsersController < ApplicationController
      include ActionController::HttpAuthentication::Token
      # before_action :authenticate_api_v1_user! #, except: [:index, :show]
      # before_action :correct_user_to_edit_library, only: [:add_new_game, :remove_game_from_user_library]
      before_action :authenticate_user
      before_action :correct_user_to_edit_profile, only: [:edit, :update, :destroy, :link_steam_account_to_user, :import_steam_library]
      # skip_before_action :verify_authenticity_token

      def index
        users = User.all
        render json: UserSerializer.new(users).serializable_hash.to_json
      end

      def show
        user = User.find(params[:id])
        render json: UserSerializer.new(user, options)
      end

      def edit
        @user = current_user
      end

      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: UserSerializer.new(user, options).serializable_hash.to_json, status: 200
        else
          render json: { error: user.errors.messages }, status: 422
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          head :no_content
        else
          render json: { error: user.errors.messages }, status: 422
        end
      end

      def add_new_game
        @user = current_user
        @videogames = Videogame.all
        @videogame = Videogame.new
      end

      def save_new_game_to_user
        # user = User.find(save_new_game_to_user_params[:user_id])
        # game = Videogame.find(save_new_game_to_user_params[:game_id])
        # user.videogames << game

        # redirect_to user_path(user)

        user = User.find(save_new_game_to_user_params[:user_id])
        game = Videogame.find(save_new_game_to_user_params[:game_id])
        user.videogames << game
        render json: UserSerializer.new(user, options).serializable_hash.to_json
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
          # params = link_steam_account_to_user_params
        # user = current_user

        # user.steam_url = params[:steam_url]

        # if user.save
        #   redirect_to user_path(user)
        # else
        #   redirect_to user_path(user)
        # end

        params = link_steam_account_to_user_params
        user = current_user
        return render json: {error: 'A Steam Account Is Already Linked To This Profile.'}, status: 422 if !user.steam_url.nil?

        user.steam_url = params[:steamUrl]

        if user.save
          render json: UserSerializer.new(user, options), status: 200
        else
          render json: { error: user.errors.messages }, status: 422
        end

      end

      def import_steam_library
        user = current_user

        user.import_steam_library
      end
      
      private

      def current_user
        token, _options = token_and_options(request)
        @current_user ||= User.find(AuthenticationTokenService.decode_token(token).to_i)

      end

      def authenticate_user
        token, _options = token_and_options(request)
        return render json: {error: 'Unauthorized Access'}, status: 401 if token.nil? || token == 'null'

        begin
          user_id = AuthenticationTokenService.decode_token(token).to_i
          User.find(user_id)
        rescue ActiveRecord::RecordNotFound
          render json: {}, status: 401
        end
      end

      def correct_user_to_edit_profile
        
        token, _options = token_and_options(request)
        render json: {error: 'Unauthorized Access'}, status: 401  if AuthenticationTokenService.decode_token(token) != params[:user_id]
      end

      def correct_user_to_edit_library
        user_library_to_edit = User.find(params[:user_id])
        redirect_to user_path(user), notice: "Not Authorized to Edit This Profile" if !is_current_user?(user_library_to_edit) 
      end

      def user_params
        params.require(:user).permit(:username, :email, :steam_id, :password)
      end

      def save_new_game_to_user_params
        params.permit(:game_id, :user_id)
      end

      def create_and_save_game_to_user_library_params
        params.permit(:user_id, :game_name, :developer, :number_of_players)
      end

      def link_steam_account_to_user_params
        params.require(:user).permit(:steamUrl)
      end

      def is_current_user?(user)
        current_user == user
      end

      def options
        @options ||= { include: %i[videogames] }
      end
    end
  end
end
