module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_authenticity_token # skip CSRF check for APIs
      respond_to :json

        def create
            user = User.find_by(email: session_params[:email])
            if user && user.valid_password?(session_params[:password])
              sign_in(user)
              session[:user_id] = user.id

              render json: {
                logged_in: true,
                user: user
              }
            else
            render json: { error: user.errors.messages }, status: 422
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
      def session_params
        params.require(:user).permit(:email, :password)
      end  

    end
  end
end
