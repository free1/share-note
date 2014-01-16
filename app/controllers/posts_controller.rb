#encoding: utf-8
class PostsController < ApplicationController
	before_filter :signed_in_user, only: [ :create, :destroy, :favorite ]
	before_filter :correct_user, only: :destroy

	# 全文搜索
	# def index
	# 	if params[:search].blank?
	# 		flash[:error] = "请输入您要查找的内容！"
	# 		redirect_to root_path
	# 	else
	# 		@search = Post.search do 
	# 			fulltext params[:search]
	# 		end
	# 		@posts = @search.results
	# 	end
	# end

	def show
		@post = Post.find(params[:id])
		#浏览计数器
		@post.increment(:viewed_count)   
		@comments = @post.comments.compact                    
		@comment = @post.comments.build
	end

	def new
		@post = current_user.posts.build
	end

	def create
		# 给文章打上标签方便检索
		@post = current_user.posts.build(title: params[:post][:title], content: params[:post][:content], kind: session[:kind])
		if @post.save
		  redirect_to post_path(@post)
		else
			# 如果文章没有保存成功则删除session
			session[:kind] = nil
			flash.now[:error] = "文章不符合标准哦！"
			render 'post_kind'
		end
	end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post
    else
      render 'edit'
    end
  end

	# 文章种类的确定
	def post_kind
		@post = current_user.posts.build
		# 用户选择了文章类型
		if params[:kind]
			# 使用session保存kind
			session[:kind] = "#{params[:kind]}"
	 		render 'new' 
	 	else
	 		render 'post_kind'
	 	end
	end

  # 文章收藏(喜爱)
  # def favorite
  #   if(current_user.favorite_topic_ids.include?(params[:id].to_s))
  #     current_user.unfavorite_topic(params[:id])
  #   else
  #     current_user.favorite_topic(params[:id])
  #   end

  #   redirect_to post_path(params[:id])
  # end

  # # 赞文章
  # def zan
  # 	if(current_user.zan_topic_ids.include?(params[:id].to_s))
  # 		current_user.yizan_topic(params[:id])
  # 	else
  # 		current_user.zan_topic(params[:id])
  # 	end

  # 	redirect_to post_path(params[:id])
  # end

  def topic_function
  	# 根据传入的值判断操作
	 	if params[:function_chose] == "favorite_topic_ids"
	 		topic_ids = current_user.favorite_topic_ids
	 		type = "favorite_topic_ids"
	 	else
	 		topic_ids = current_user.zan_topic_ids
	 		type = "zan_topic_ids"
	 	end	
    # 根据是否关注(赞)选择方法
 		if(topic_ids.include?(params[:id].to_s))
      current_user.cancel_topic(params[:id], topic_ids, type)
    else
      current_user.operate_topic(params[:id], topic_ids, type)
    end

    redirect_to post_path(params[:id])
  end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private 
		def correct_user
			@post = Post.find(params[:id])
			redirect_to root_path if @post.nil?
		end

end
