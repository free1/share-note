class Comment < ActiveRecord::Base
  attr_accessible :body, :commenter

  # 属于一个post
  belongs_to :post
  # 有多个站内通知
  has_many :notifications
  after_create :send_notifications

  validates :post_id, presence: true
  validates :commenter, presence: true
  validates :body, presence: true, length: { maximum: 600 }

  private
  	def send_notifications
  		# 找到所评论文章的用户
		  notification_user = self.post.user
  		Notification.create(user_id: notification_user.id, unread: true, comment_id: self.id) 
  	end
end
