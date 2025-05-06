class ThreadChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "thread_chat_channel"
  end

  def unsubscribed
    # Cleanup when channel is unsubscribed
  end
end

