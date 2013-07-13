#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :website, :github,
                  :twitter, :qq, :city, :company, :position, :autograph, :resume
  has_secure_password

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
              class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { |user| user.email = email.downcase }
  before_create { create_remember_token(:remember_token) }
  before_save { github_url }
  before_save { twitter_url }
  before_save { website_url }
 
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
  validates_uniqueness_of :email, case_sensitive: false, message: "已存在!"

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


  private
    # 创建密码保护
    def create_remember_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
