module Api
  module V1
    class SubthreadsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_discussion_thread

      # List all subthreads of a discussion thread
      def index
        subthreads = @discussion_thread.subthreads.order(created_at: :desc)
        render json: subthreads, status: :ok
      end

      # Create a subthread
      def create
        subthread = @discussion_thread.subthreads.build(subthread_params.merge(user: current_user))
        if subthread.save
          render json: { message: "Subthread created successfully", subthread: subthread }, status: :created
        else
          render json: { errors: subthread.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_discussion_thread
        @discussion_thread = DiscussionThread.find(params[:discussion_thread_id])
      end

      def subthread_params
        params.require(:subthread).permit(:title, :body)
      end
    end
  end
end
