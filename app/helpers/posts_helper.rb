module PostsHelper

  # 文章收藏
  # def topic_favorite_tag(topic)
  #   return "" if current_user.blank?
  #   link_title = "收藏"
  #   if current_user && current_user.favorite_topic_ids.include?(topic.id.to_s)
  #     link_title = "取消收藏"
  #   end

  #   link_to "#{link_title}", controller: 'posts', action: 'favorite'
  # end

  # def topic_zan_tag(topic)
  #   return "" if current_user.blank?
  #   link_title = "赞"
  #   if current_user && current_user.zan_topic_ids.include?(topic.id.to_s)
  #     link_title = "已赞"
  #   end

  #   link_to "#{link_title}", controller: 'posts', action: 'zan'
  # end

  # 文章功能
  def topic_function_tag(topic, function_topic_ids, *link_title_chose)
    return "" if current_user.blank?
    link_title = link_title_chose[0]
    # 根据传入的值判断操作
    topic_ids = function_topic_ids == 'favorite_topic_ids' ? current_user.favorite_topic_ids : current_user.zan_topic_ids
    if current_user && topic_ids.include?(topic.id.to_s)
      link_title = link_title_chose[1]
    end

    link_to "#{link_title}", controller: 'posts', action: 'topic_function', function_chose: "#{function_topic_ids}"
  end
end
