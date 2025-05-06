module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, except: [:index, :show]
      before_action :set_user, only: [:show, :update, :destroy]

      # ✅ Get All Users (GET /api/v1/users)
      def index
        users = User.all
        render json: users, status: :ok
      end

      # ✅ Get a Single User by ID (GET /api/v1/users/:id)
      def show
        render json: @user, status: :ok
      end

      # ✅ Get Current User Profile (GET /api/v1/users/profile)
      def profile
        render json: current_user, status: :ok
      end

      # ✅ Update User Profile (PUT /api/v1/users/update)
      def update
        if current_user.update(user_params)
          render json: { message: "Profile updated successfully", user: current_user }, status: :ok
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # ✅ Change Password (PUT /api/v1/users/change_password)
      def change_password
        if current_user.update(password_params)
          render json: { message: "Password updated successfully" }, status: :ok
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # ✅ Delete a User (DELETE /api/v1/users/:id)
      def destroy
        if @user.destroy
          render json: { message: "User deleted successfully" }, status: :ok
        else
          render json: { error: "Failed to delete user" }, status: :unprocessable_entity
        end
      end

      private

      # 🔹 Find User by ID
      def set_user
        @user = User.find_by(id: params[:id])
        render json: { error: "User not found" }, status: :not_found unless @user
      end

      # 🔹 Strong Parameters for Profile Update
      def user_params
        params.permit(:username, :email, :bio, :role, :profile_photo)
      end

      # 🔹 Strong Parameters for Changing Password
      def password_params
        params.require(:user).permit(:password, :password_confirmation)
      end
    end
  end
end
