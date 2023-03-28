class UsersController < ApplicationController
    def create
        user = User.create(user_params)

        if user.save 
            session[:user_id] = user.id
            render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        if current_user
          render json: current_user
        else
          render json: { error: "Not authorized" }, status: :unauthorized
        end
      end
    
      private
    
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
end
