class CreateThreadChats < ActiveRecord::Migration[7.1]
  def change
    create_table :thread_chats do |t|
      t.string :title

      t.timestamps
    end
  end
end
