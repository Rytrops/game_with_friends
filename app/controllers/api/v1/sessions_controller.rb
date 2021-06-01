module Api
  module V1
    class SessionsController < Devise::SessionsController
      #I think i need this part but im not sure why
      skip_before_action :verify_authenticity_token # skip CSRF check for APIs
      respond_to :json

        def create
            user = User.find_by(email: session_params[:email])
            #is this secure irt password handling?
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
          # user = User.find_by(email: session_params[:email])
          # sign_out(user)
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
