class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @thread = DiscussionThread.find(params[:discussion_thread_id])
    @comment = @thread.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to discussion_thread_path(@thread), notice: "Comment added!"
    else
      redirect_to discussion_thread_path(@thread), alert: "Failed to add comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
