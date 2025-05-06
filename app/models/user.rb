class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :notifications, dependent: :destroy
  
  serialize :notification_preferences, Hash
  has_many :thread_chats, dependent: :destroy
  after_create :create_user_preference  # Ensure preference exists
  def prefers_notification?(type)
    preferences&.fetch(type.to_s, false) || false
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :profile_photo
         enum role: { participant: 0, moderator: 1, admin: 2 }
  
         has_many :discussion_threads
         has_many :comments
         validates :bio, length: { maximum: 500 }
         validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }

        def admin?
          role == "admin"
        end
      
        def moderator?
          role == "moderator"
        end

        def self.ransackable_attributes(auth_object = nil)
          ["id", "username", "email", "bio", "role", "created_at", "updated_at"]
        end

        def self.ransackable_associations(auth_object = nil)
          ["comments", "discussion_threads", "profile_photo_attachment", "profile_photo_blob"]
        end

        private

  def create_user_preference
    UserPreference.create(user: self, notifications_enabled: true)
  end
end
