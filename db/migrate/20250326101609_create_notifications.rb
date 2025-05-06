class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :notifiable, polymorphic: true
      t.text :message
      t.boolean :read

      t.timestamps
    end
  end
end
