class AddParentIdToDiscussionThreads < ActiveRecord::Migration[7.1]
  def change
    add_column :discussion_threads, :parent_id, :integer
  end
end
