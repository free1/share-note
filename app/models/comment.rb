class Comment < ActiveRecord::Base
  attr_accessible :body, :commenter

  belongs_to :post

  validates :post_id, presence: true
  validates :commenter, presence: true
  validates :body, presence: true, length: { maximum: 600 }
end
