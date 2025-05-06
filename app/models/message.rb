class Message < ApplicationRecord
  belongs_to :thread_chat
  belongs_to :user
  belongs_to :reply_to, class_name: "Message", optional: true
  
  has_many :replies, class_name: "Message", foreign_key: "reply_to_id", dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  after_create_commit :process_mentions_and_replies
  after_create_commit :broadcast_message

  private

  def process_mentions_and_replies
    notify_replied_user if reply_to_id.present?
    notify_mentions
  end

  # ✅ Notify the original message sender (if this is a reply)
  def notify_replied_user
    return if reply_to.user == user  # Avoid self-notifications
  
    Notification.create!(
      user: reply_to.user,
      notifiable: self,
      notifiable_type: "Message",
      notifiable_id: self.id,
      message: "#{user.username} replied to your message",
      read: false
    )
    
    broadcast_notification(reply_to.user)
  end
  
  def notify_mentions
    mentioned_users.each do |mentioned_user|
      next if mentioned_user == user  # Avoid self-mentions
  
      Notification.create!(
        user: mentioned_user,
        notifiable: self,
        notifiable_type: "Message",
        notifiable_id: self.id,
        message: "#{user.username} mentioned you in '#{thread_chat.title}'",
        read: false
      )
  
      broadcast_notification(mentioned_user)
    end
  end
  

  # ✅ Extract mentioned users from message content
  def mentioned_users
    usernames = content.scan(/@(\w+)/).flatten
    User.where(username: usernames)
  end

  # ✅ Broadcast new notification in real-time
  def broadcast_notification(user)
    NotificationsChannel.broadcast_to(user, {
      message: "#{user.username}, you have a new notification!",
      unread_count: user.notifications.unread.count
    })
  end

  # ✅ Broadcast new messages using Turbo Streams
  def broadcast_message
    broadcast_append_to "messages",
                        target: "messages",
                        partial: "messages/message",
                        locals: { message: self },
                        formats: [:html]
  end
end
