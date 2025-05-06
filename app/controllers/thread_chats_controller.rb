class ThreadChatsController < ApplicationController
  before_action :set_thread_chat, only: [:show]

  def index
    @threads = ThreadChat.all
  end

  def create
    @thread_chat = current_user.thread_chats.build(thread_chat_params)
  
    if @thread_chat.save
      redirect_to thread_chats_path, notice: "Chat thread created!"
    else
      render :new
    end
  end

  private

  def thread_chat_params
    params.require(:thread_chat).permit(:title)
  end

  def set_thread_chat
    @thread_chat = ThreadChat.find_by(id: params[:id])
    unless @thread_chat
      flash[:alert] = "Thread not found"
      redirect_to root_path
    end
  end
end
