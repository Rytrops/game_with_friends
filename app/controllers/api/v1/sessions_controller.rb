module Api
  module V1
    class SessionsController < Devise::SessionsController

      skip_before_action :verify_authenticity_token # skip CSRF check for APIs
      respond_to :json

        def create
            user = User.find_by(email: session_params[:email])
            debugger
            if user && user.valid_password?(session_params[:password])
              session[:user_id] = user.id
              render json: {
                logged_in: true,
                user: @user
              }
            else
            render json: { error: user.errors.messages }, status: 422
            end
        end

      #   def create
      #     self.resource = warden.authenticate!(auth_options)
      #     set_flash_message!(:notice, :signed_in)
      #     sign_in(resource_name, resource)
      #     yield resource if block_given?
      #     respond_with(resource)
      #  end

      #  def respond_with(resource, opts = {})
      #    render json: resource.as_json(only: [:id,:email, :name, ... ])
      #                       .merge!({token: resource.token})
      #  end

      private
      def session_params
        params.require(:user).permit(:email, :password)
      end  

    end
  end
end
