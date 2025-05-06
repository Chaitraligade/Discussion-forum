class Notification < ApplicationRecord
  belongs_to :user
  # belongs_to :notifiable, polymorphic: true
  belongs_to :notifiable, polymorphic: true, optional: true

  scope :unread, -> { where(read: false) }

  # after_create_commit do
  #   broadcast_append_to "notifications_#{user.id}",
  #                       target: "notifications",
  #                       partial: "notifications/notification", # ✅ Ensure correct partial name
  #                       locals: { notification: self }
  # end
  after_create_commit do
    broadcast_prepend_to "notifications",
                         target: "notifications",
                         partial: "notifications/notification",
                         locals: { notification: self }
  end
  
end
