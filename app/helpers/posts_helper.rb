module PostsHelper

  # 文章收藏
  def topic_favorite_tag(topic)
    return "" if current_user.blank?
    link_title = "收藏"
    if current_user && current_user.favorite_topic_ids.include?(topic.id.to_s)
      link_title = "取消收藏"
    end

    link_to "#{link_title}", controller: 'posts', action: 'favorite'
  end

end
