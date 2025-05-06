class DiscussionThread < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true 
  has_many :thread_chats, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subthreads, class_name: "DiscussionThread", foreign_key: "parent_id"
  belongs_to :parent, class_name: "DiscussionThread", optional: true
  has_many :replies, class_name: "DiscussionThread", foreign_key: "parent_id"
  has_many_attached :files
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user: user)
  end
  acts_as_taggable_on :tags

  scope :by_category, ->(category_id) {
    where(category_id: category_id) if category_id.present?
  }
  # Allowlist searchable attributes for Ransack in ActiveAdmin
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "body", "user_id", "created_at", "updated_at"]
  end

  # Allowlist searchable associations for Ransack in ActiveAdmin
  def self.ransackable_associations(auth_object = nil)
    ["user", "comments"]
  end
end
