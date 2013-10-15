class Tag < ActiveRecord::Base
    attr_accessible :kind, :language

    # 给文章打标签
    has_many :posts
    # belongs_to :post

    validates :post_id, presence: true
    validates :kind, presence: true
    validates :language, presence: true

    # def self.tag_search_posts(tag)
    #     Tag.includes(:post).where(kind: "#{tag}")
    # end

end
