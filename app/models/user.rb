#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation,  :website, :github,
                  :twitter, :qq, :city, :company, :position, :autograph, :resume
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_create { create_remember_token(:remember_token) }

  # validates :name, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true,
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }
  # validates :password, presence: true, length: { minimum: 6 }, :if => :new_record?
  # validates :password_confirmation, presence: true, :if => :new_record?

  validates_presence_of :name, :email, :password, :password_confirmation, 
                        message: "不能为空!", if: :new_record? #password reset bug
  validates_length_of :name, :password, in: 1..20, message: "必须为1到10的字符!",
                        if: :new_record? #password reset bug
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX, message: "格式不正确!"
  validates_uniqueness_of :email, case_sensitive: false, message: "已存在!"

  validates_numericality_of :qq, only_integer: true, allow_nil: true, message: "必须是整数!"

  def send_password_reset
    create_remember_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private
    def create_remember_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
