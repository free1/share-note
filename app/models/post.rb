class Post < ActiveRecord::Base
	attr_accessible :content, :title, :tag_id

	has_many :comments, dependent: :destroy
	# 给文章打标签,一篇文章有一个标签用来索引
	belongs_to :tag

	belongs_to :user

	validates :user_id, presence: true
	validates :tag_id, presence: true
	validates :title, presence: true, length: { maximum: 50 }
	validates :content, presence: true, length: { maximum: 900 }

	default_scope order: 'posts.created_at DESC'

	# 全文搜索
	searchable do 
		text :title, :content
		text :comments do
			comments.map { |comment| comment.body  }
		end
	end

	#浏览计算器
	def increment(attribute, by = 1)
		self[attribute] ||= 0
		self[attribute] += by
		self.save
	end
end
