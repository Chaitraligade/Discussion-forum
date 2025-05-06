class Api::V1::DiscussionThreadsController < ApplicationController
  before_action :set_thread, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @threads = DiscussionThread.all
    render json: @threads
  end

  def show
    render json: @thread
  end

  def create
    @thread = current_user.discussion_threads.build(thread_params)
    if @thread.save
      render json: @thread, status: :created
    else
      render json: { errors: @thread.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @thread.update(thread_params)
      render json: @thread
    else
      render json: { errors: @thread.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @thread.destroy
    head :no_content
  end

  private

  def set_thread
    @thread = DiscussionThread.find(params[:id])
  end

  def thread_params
    params.require(:discussion_thread).permit(:title, :body)
  end
end
