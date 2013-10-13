class Tag < ActiveRecord::Base
  attr_accessible :kind, :language

  belongs_to :post

  # validates :post_id, presence: true
  # validates :kind, presence: true
  # validates :language, presence: true

 
end
