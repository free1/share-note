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
    # 找到需要通知的用户
    def find_user
      # 匹配找到@ 到的人
      at_users = self.body.scan(/@([a-zA-Z0-9_\-\p{han}]+)/u).flatten
      # 存放需要通知用户的数组
      notification_users_id = []
      unless at_users.blank?
          at_users.each do |at_user|
            exist_user =  User.find_by_name(at_user)
            # 用户存在则把id加入数组
            unless exist_user.nil?
              notification_users_id << exist_user.id 
            end
          end
          notification_users_id
      end
      # 将发表文章的人加进来
      notification_users_id << self.post.user.id
      # 去掉重复的人
      notification_users_id.uniq
    end

    # 创建通知提醒
  	def send_notifications
     	# 找到所评论文章的用户
		  find_user.each do |notification_user_id|
  		  Notification.create(user_id: notification_user_id, unread: true, comment_id: self.id) # 加入发表人评论不用收到通知
      end
  	end
end
