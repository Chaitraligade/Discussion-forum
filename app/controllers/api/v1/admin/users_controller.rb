module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :authorize_admin

        def index
          users = User.all
          render json: users
        end

        def update
          user = User.find(params[:id])
          if user.update(user_params)
            render json: { message: 'User updated successfully', user: user }
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          user = User.find(params[:id])
          user.destroy
          render json: { message: 'User deleted' }
        end

        private

        def user_params
          params.permit(:role)
        end

        def authorize_admin
          render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
        end
      end
    end
  end
end

