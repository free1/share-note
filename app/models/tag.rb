class Tag < ActiveRecord::Base
    attr_accessible :kind, :language

    # 给文章打标签
    has_many :posts

    validates :kind, presence: true
    validates :language, presence: true

end
