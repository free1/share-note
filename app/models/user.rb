#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :website, :github,
                  :twitter, :qq, :city, :company, :position, :autograph, :resume,
                  :avatar, :avatar_cache, :favorite_topic_ids, :zan_topic_ids
  # 安全密码
  has_secure_password

  # 发表文章
  has_many :posts, dependent: :destroy

  # 评论列表
  has_many :comments, dependent: :destroy

  # 第三方登录
  has_many :authentications

  # 上传文件(头像)
  mount_uploader :avatar, AvatarUploader

  # 站内通知提醒
  has_many :notifications, dependent: :destroy

  # 签到功能
  has_many :qiandaos, dependent: :destroy

  # 用户关注
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
              class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  # 存入数据库之前
  before_save { |user| user.email = email.downcase }
  before_save { |user| user.name = name.downcase }
  before_create { create_remember_token(:remember_token) }
  before_save { github_url }
  before_save { twitter_url }
  before_save { website_url }
  # 如果首次收藏文章把nil变成空字符串
  before_save { self.favorite_topic_ids = " " if self.favorite_topic_ids == nil }
  before_save { self.zan_topic_ids = " " if self.zan_topic_ids == nil }

  # 用户身份验证
  # validates :name, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true,
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }
  # validates :password, presence: true, length: { minimum: 6 }, :if => :new_record?
  # validates :password_confirmation, presence: true, :if => :new_record?
  validates_presence_of :name, :email, :password, :password_confirmation, 
                        message: "不能为空!", if: :new_record? #password reset bug
  validates_length_of :name, :password, in: 1..20, message: "必须为1到20的字符!",
                        if: :new_record? #password reset bug
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX, message: "格式不正确!"
  validates_uniqueness_of :email, :name, case_sensitive: false, message: "已存在!"

  # 用户资料验证
  validates_numericality_of :qq, only_integer: true, allow_nil: true, message: "必须是整数!"


  # 发送密码找回邮件
  def send_password_reset
    create_remember_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end


  # 用户关注
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end


  # 格式验证
  def github_url
    return "" if self.github.blank?
    "https://github.com/#{self.github.split('/').last}"
  end
  def twitter_url
    return "" if self.twitter.blank?
    "https://twitter.com/#{self.twitter}"
  end
  def website_url
    return "" if self.website.blank?
    "http://#{self.website}"
  end


  # 第三方登录(github)
  class << self
    # 判断用户是否存在
    def from_auth(auth)
      locate_auth(auth) || create_auth(auth)
    end
    # 查找用户
    def locate_auth(auth)
      Authentication.find_by_provider_and_uid(auth[:provider], auth[:uid]).try(:user)
    end
    # 创建新用户
    def create_auth(auth)
      User.new do |user|
        user.name = auth[:info][:nickname]
        user.email = auth[:info][:email]
        # 提取头像并设置头像
        # user.avatar = auth[:info][:image]
        # 生成无用的密码保护
        user.password_digest = "#{SecureRandom.urlsafe_base64}"
        # user.auth_token = auth[:token]
        user.authentications.build do |authentication|
          authentication.provider = auth[:provider]
          authentication.uid = auth[:uid]
          authentication.save
        end
         user.save!(validate: false)
      end
    end
  end


  # # 收藏功能
  # def favorite_topic(post_id)
  #   return false if post_id.blank?
  #   return false if self.favorite_topic_ids.include?(post_id)
  #   # 把文章id存入数据库
  #   post_ids = self.favorite_topic_ids.insert(1, ",#{post_id}")
  #   # 测试post_ids是否正确
  #   # logger.debug { "---#{post_ids}" }
  #   self.update_attribute(:favorite_topic_ids, "1")   # 不使用这句无法将数据存入数据库
  #   self.update_attribute(:favorite_topic_ids, post_ids)
  # end
  # # 取消收藏
  # def unfavorite_topic(post_id)
  #   return false if post_id.blank?
  #   # 删除选中的文章id
  #   post_ids = self.favorite_topic_ids.split(",")
  #   post_ids.delete "#{post_id}"
  #   post_ids_result = post_ids.join(",")
  #   # 测试post_ids_result是否正确
  #   # logger.debug { "---#{post_ids_result}" }
  #   self.update_attribute(:favorite_topic_ids, post_ids_result)
  # end

  # # 赞功能
  # def zan_topic(post_id)
  #   return false if post_id.blank?
  #   return false if self.zan_topic_ids.include?(post_id)
  #   # 把文章id存入数据库
  #   post_ids = self.zan_topic_ids.insert(1, ",#{post_id}")
  #   self.update_attribute(:zan_topic_ids, "1")
  #   self.update_attribute(:zan_topic_ids, post_ids)
  # end
  # # 已赞
  # def yizan_topic(post_id)
  #   return false if post_id.blank?
  #   # 删除选中的文章id
  #   post_ids = self.zan_topic_ids.split(",")
  #   post_ids.delete "#{post_id}"
  #   post_ids_result = post_ids.join(",")
  #   self.update_attribute(:zan_topic_ids, post_ids_result)
  # end

  # 文章操作(收藏，赞)
  def operate_topic(post_id, topic_ids, type)
    return false if post_id.blank?
    return false if topic_ids.include?(post_id)
    # 把文章id存入数据库
    post_ids = topic_ids.insert(1, ",#{post_id}")
    self.update_attribute(type, "1")
    self.update_attribute(type, post_ids)
  end
  # 取消
  def cancel_topic(post_id, topic_ids, type)
    return false if post_id.blank?
    # 删除选中的文章id
    post_ids = topic_ids.split(",")
    post_ids.delete "#{post_id}"
    post_ids_result = post_ids.join(",")
    self.update_attribute(type, post_ids_result)
  end


  private
    # 创建密码保护
    def create_remember_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
