module Moderator
  class DashboardController < ApplicationController
    before_action :authenticate_user!  # Ensure user is logged in
    before_action :authorize_moderator # Restrict access to moderators and admins

    def index
      @users = User.all
      @discussion_threads = DiscussionThread.order(created_at: :desc)
      @comments = Comment.order(created_at: :desc)
    end

    private

    # def authorize_moderator
    #   unless current_user&.moderator? || current_user&.admin?
    #     redirect_to root_path, alert: "Access denied! Only moderators and admins can view this page."
    #   end
    # end

  def authorize_moderator
    redirect_to root_path, alert: "Access denied" unless current_user&.moderator?
  end
  end
end
