class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @notification = current_user.notifications.create(notification_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "Notification sent!" }
    end
  end
  # def index
  #   @notifications = current_user.notifications.unread.order(created_at: :desc)
  #   @unread_count = @notifications.count
  # end
  def index
    @notifications = Notification.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true) # Mark it as read when opened
  end
  
  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update!(read: true)

    redirect_to notifications_path, notice: "Notification marked as read."
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Notification not found" }, status: :not_found
  end

  # def mark_all_as_read
  #   current_user.notifications.update_all(read: true)
  #   redirect_to notifications_path, notice: "All notifications marked as read."
  # end

  private

  def notification_params
    params.require(:notification).permit(:message)
  end
end
