class DiscussionThreadsController < ApplicationController
 
  before_action :authenticate_user!, only: [:new, :create]
 
  def index
    @categories = Category.all  
    @notifications = user_signed_in? ? current_user.notifications.to_a : []  # Ensure it's always an array
  
    # Filtering by category
    @threads = params[:category_id].present? ? DiscussionThread.where(category_id: params[:category_id]) : DiscussionThread.all
  
    # Sorting Logic
    @threads = params[:sort] == "oldest" ? @threads.order(created_at: :asc) : @threads.order(created_at: :desc)
  
    # Pagination
    @threads = @threads.page(params[:page]).per(1)
  end
  
  

  def show
    @thread = DiscussionThread.find(params[:id])
    @comment = Comment.new
    @subthreads = @thread.subthreads # Fetch subtopics (child threads)
  end

  def new
    @thread = DiscussionThread.new(parent_id: params[:parent_id]) # Support for subtopics
  end

  def create
    @discussion_thread = current_user.discussion_threads.build(thread_params)
    if @discussion_thread.save
      respond_to do |format|
        format.html { redirect_to @discussion_thread, notice: "Thread created successfully!" }
        format.json { render json: { message: "Thread created successfully", thread: @discussion_thread }, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { error: @discussion_thread.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def thread_params
    params.require(:discussion_thread).permit(:title, :body, :parent_id, :tag_list, :category_id, files: [])
  end

  def sort_order
    params[:sort] == "oldest" ? :asc : :desc  # Default: newest first
  end
end
