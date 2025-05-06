class CreateUserPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :user_preferences do |t|
      t.references :user, foreign_key: true
      t.boolean :notifications_enabled

      t.timestamps
    end
  end
end
