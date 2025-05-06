class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @thread = DiscussionThread.find(params[:discussion_thread_id])
    @thread.likes.create!(user: current_user)
    redirect_to @thread
  end

  def destroy
    @thread = DiscussionThread.find(params[:discussion_thread_id])
    @thread.likes.where(user: current_user).destroy_all
    redirect_to @thread
  end
end
