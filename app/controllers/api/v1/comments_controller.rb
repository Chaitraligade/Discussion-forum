module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_thread

      # POST /api/v1/discussion_threads/:discussion_thread_id/comments
      def create
        comment = @thread.comments.build(comment_params.merge(user: current_user))

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_thread
        @thread = DiscussionThread.find(params[:discussion_thread_id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end

