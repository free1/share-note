class AddFollowNotificationIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :follow_notification_id, :integer
  end
end
