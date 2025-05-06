class AddUserToThreadChats < ActiveRecord::Migration[7.1]
  def change
    add_reference :thread_chats, :user, foreign_key: true
  end
end
