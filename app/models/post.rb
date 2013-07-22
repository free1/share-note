class Post < ActiveRecord::Base
  attr_accessible :content, :title

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 900 }

  default_scope order: 'posts.created_at DESC'
end
