class NotificationService
  def self.send_notification(user, message)
    # Check if the user has preferences set
    preferences = user.user_preference || UserPreference.new

    # Store notification in the database
    user.notifications.create!(message: message)

    # Send email if enabled
    NotificationMailer.notify(user, message).deliver_later if preferences.email_notifications

    # TODO: Implement push & SMS notifications if required
  end
end
