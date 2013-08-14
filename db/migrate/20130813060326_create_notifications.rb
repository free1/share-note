class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :unread
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
