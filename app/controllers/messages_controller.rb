class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_thread_chat

  def index
    @messages = @thread_chat.messages.includes(:user).order(created_at: :asc)
  end

  def create
    @message = @thread_chat.messages.build(message_params.merge(user: current_user))

    if @message.save
      # ✅ Notify the thread owner if they are not the sender
      notify_thread_owner unless @thread_chat.user == current_user

      # ✅ Notify mentioned users
      notify_mentioned_users(@message)

      # ✅ Notify original sender (if reply)
      notify_replied_user(@message)

      respond_to do |format|
        format.html { redirect_to @thread_chat }
        format.turbo_stream
      end
    else
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
 
  def notify_mentioned_users(message)
    mentioned_users = extract_mentions(message.content)
    
    mentioned_users.each do |user|
      next if user == current_user  # Avoid self-mentions
  
      notification = Notification.create(
        user: user,
        notifiable: message,
        message: "#{current_user.username} mentioned you in '#{message.thread_chat.title}'",
        read: false
      )
  
      if notification.persisted?
        puts "✅ Notification created for #{user.username}"
      else
        puts "❌ Notification failed: #{notification.errors.full_messages}"
      end
    end
  end
  
  def set_thread_chat
    @thread_chat = ThreadChat.find(params[:thread_chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :reply_to_id)
  end

  # ✅ Notify the thread owner about new messages
  def notify_thread_owner
    Notification.create!(
      user: @thread_chat.user,
      notifiable: @message,
      message: "New message from #{current_user.username}",
      read: false
    )
  end

  # ✅ Notify mentioned users
  def notify_mentioned_users(message)
    mentioned_users = extract_mentions(message.content)
  
    mentioned_users.each_with_index do |user, index|
      next if user == message.user  # Avoid self-mentions
  
      Notification.create!(
        user: user,
        notifiable: message,
        message: "#{message.user.username} mentioned you in '#{message.thread_chat.title}' (Mention ##{index + 1})",
        read: false
      )
    end
  end
  
  

  # ✅ Notify the original message sender when a message is a reply
  def notify_replied_user(message)
    return unless message.reply_to_id

    original_message = Message.find_by(id: message.reply_to_id)
    return unless original_message && original_message.user != current_user

    Notification.create!(
      user: original_message.user,
      notifiable: message,
      message: "#{current_user.username} replied to your message",
      read: false
    )
  end

  # ✅ Extract mentioned usernames from the message content
  def extract_mentions(content)
    usernames = content.scan(/@(\w+)/).flatten
    users = usernames.map { |username| User.find_by(username: username) }.compact
    puts users.map(&:username).inspect  # Check if duplicate users exist
    users
  end
  
  extract_mentions("Hey @mayuri how are you? @mayuri tell me")
  
end
