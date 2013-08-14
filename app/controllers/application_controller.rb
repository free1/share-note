class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  # 初始化程序
  before_filter :init

  def init
  	# 站内通知	
  	count_unread_notification
  end

  private
  	# 站内通知
  	def count_unread_notification
  		if current_user
  			@unread_count = current_user.notifications.where(unread: true).count
  		else
  			@unread_count = 0
  		end
  	end
end

