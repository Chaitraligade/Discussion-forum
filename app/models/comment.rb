class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion_thread
  has_ancestry

  def self.ransackable_attributes(auth_object = nil)
    ["id", "body", "user_id", "discussion_thread_id", "created_at", "updated_at"]
  end


  private

  def notify_mentions
    mentioned_users.each do |user|
      Notification.create!(
        user: user,
        notifiable: self,
        action: "mentioned"
      )

      # Send WebSocket notification
      NotificationsChannel.broadcast_to(user, message: "#{self.user.name} mentioned you!")
    end
  end

  def mentioned_users
    usernames = self.body.scan(/@(\w+)/).flatten
    User.where(username: usernames)
  end
end
