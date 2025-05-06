class Like < ApplicationRecord
  belongs_to :user
  belongs_to :discussion_thread
end
