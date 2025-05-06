class AddThreadChatToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :thread_chat, foreign_key: true
  end
end
