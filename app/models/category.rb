class Category < ApplicationRecord
  has_many :discussion_threads, dependent: :destroy # A category has many threads
  validates :name, presence: true, uniqueness: true
end
