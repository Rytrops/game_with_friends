module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      
      # def index
      #   # @users = User.all
      #   users = User.all
      #   render json: UserSerializer.new(users, options).serializable_hash.to_json
      # end

      def new
          # @user = User.new
          user = User.new
      end
      

      def create
        #   @user = User.new(user_params)

        #   if @user.save
        #       redirect_to @user
        #   else
        #       render :new
        #   end
          user = User.new(user_params)
          if user.save
            render json: UserSerializer.new(user).serializable_hash.to_json
          else
            render json: { error: user.errors.messages }, status: 422
          end
      end
      
      def edit
          @user = User.find(params[:id])
      end

      private

      def user_params
        # params.permit(:username, :email, :steam_id, :password)
        params.require(:user).permit(:username, :email, :steam_id, :password)
      end

      def save_new_game_to_user_params
          params.permit(:game_id, :user_id)
      end

      def create_and_save_game_to_user_library_params
          params.permit(:user_id, :game_name, :developer, :number_of_players)
      end
    end
  end
end

