module NotificationsHelper
  # 使用id找到用户名
  def find_follow_user(user_id)
    user = User.find(user_id)
    user.name
  end
end
