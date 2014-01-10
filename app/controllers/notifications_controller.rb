class NotificationsController < ApplicationController

	after_filter :mark_read, only: :index

	def index
		@notifications = current_user.notifications.recent
	end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path
  end

	def mark_read
		current_user.notifications.update_all(unread: false)
	end

end
