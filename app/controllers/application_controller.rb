
class ApplicationController < ActionController::Base
  # include Pundit
  before_action :set_action_cable_user
  include Devise::Controllers::Helpers
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_minimum_password_length, if: :devise_controller?
  before_action :load_notifications

  protected
  
def load_notifications
  @notifications = current_user.notifications.unread if user_signed_in?
end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:bio, :role, :profile_photo, :username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:bio, :role, :profile_photo, :username])
  end
end


private

def set_action_cable_user
  cookies.encrypted[:user_id] = current_user.id if current_user
end