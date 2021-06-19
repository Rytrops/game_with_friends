module Api
  module V1
    class AuthenticationController < ApplicationController
      respond_to :json

      def create
        if user&.valid_password?(sign_in_params[:password])
          token = AuthenticationTokenService.encode_token(user)
          render json: {
            token: token,
            logged_in: true,
            user: user
          }, status: :created
        else
          render json: [error: { message: 'Invalid Login Credentials' }], status: 422
        end
      end

      def destroy
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
      def user
        @user ||= User.find_by(email: sign_in_params[:email])
      end

    end
  end
end
