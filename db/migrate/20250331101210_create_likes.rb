class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :discussion_thread, foreign_key: true

      t.timestamps
    end
  end
end
