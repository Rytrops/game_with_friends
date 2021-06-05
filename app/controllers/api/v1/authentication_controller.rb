module Api
  module V1
    class AuthenticationController < ApplicationController

          #I think i need this part but im not sure why
      skip_before_action :verify_authenticity_token # skip CSRF check for APIs
      respond_to :json

      def create
          user = User.find_by(email: sign_in_params[:email])
          if user&.valid_password?(sign_in_params[:password])
            token = AuthenticationTokenService(user)
            render json: {
              token: {},
              logged_in: true,
              user: user
            }
          else
            render json: { error: user.errors.messages }, status: 422
          end
      end

      def destroy
        # user = User.find_by(email: sign_in_params[:email])
        # sign_out(user)
        session.clear
        render json: {
          status: 200,
          logged_out: true
        }

      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end

    end
  end
end


    #   rescue_from ActionController::ParameterMissing, with: :parameter_missing

    #   def create
    #     p params.require.(:username).inspect
    #     p params.require.(:password).inspect
    #     p params.require.(:email).inspect



    #     render json: {token: '123' }, status: :created

    #   end

    #   private
    #   def parameter_missing
    #     render json: { error: e.message }, statues: :unprocessable_entity
    #   end

    #   def user_params

    #   end
    # end