class Post < ActiveRecord::Base
	attr_accessible :content, :title, :viewed_count

	has_many :comments
	belongs_to :user

	validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 50 }
	validates :content, presence: true, length: { maximum: 900 }

	default_scope order: 'posts.created_at DESC'

	#浏览计算器
	def increment(attribute, by = 1)
		self[attribute] ||= 0
		self[attribute] += by
		self.save
	end
end
