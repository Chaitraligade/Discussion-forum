class AddCategoryToDiscussionThreads < ActiveRecord::Migration[7.1]
  def change
    add_column :discussion_threads, :category_id, :integer
  end
end
