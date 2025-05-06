class ThreadChat < ApplicationRecord
  # has_many :messages, dependent: :destroy
  self.table_name = "thread_chats"
  belongs_to :discussion_thread, class_name: "DiscussionThread", foreign_key: "thread_id"

  belongs_to :user, optional: true
  has_many :messages, class_name: "Message", dependent: :destroy
  after_create_commit :notify_users
  def self.ransackable_associations(auth_object = nil)
    ["user", "messages"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "created_at", "updated_at"]
  end
  
  private 

  def notify_users
    return unless discussion_thread.present? # Prevents calling methods on nil
  
    recipients = discussion_thread.users.where.not(id: user_id)
    recipients.each do |recipient|
      Notification.create(user_id: recipient.id, message: "#{user.username} sent a message in #{discussion_thread.title}")
    end
  end
  
  
end
