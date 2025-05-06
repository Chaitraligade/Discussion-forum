module Api
  module V1
    module Moderator
      class UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :authorize_moderator

        def index
          users = User.where.not(role: :admin)
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

        private

        def user_params
          params.permit(:role)
        end

        def authorize_moderator
          render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.moderator? || current_user.admin?
        end
      end
    end
  end
end
