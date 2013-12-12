#encoding: utf-8
class PostsController < ApplicationController
	before_filter :signed_in_user, only: :create
	# before_filter :signed_in_user, only: [ :create, :destroy ]
	# before_filter :correct_user, only: :destroy

	# 全文搜索
	def index
		if params[:search].blank?
			flash[:error] = "请输入您要查找的内容！"
			redirect_to root_path
		else
			@search = Post.search do 
				fulltext params[:search]
			end
			@posts = @search.results
		end
	end

	def show
		@post = Post.find(params[:id])
		#浏览计数器
		@post.increment(:viewed_count)   
		@comments = @post.comments                    
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
			flash.now[:error] = "文章标题和内容都不可以为空哦！"
			render 'post_kind'
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
  def favorite
    if(current_user.favorite_topic_ids.include?(params[:id].to_s))
      current_user.unfavorite_topic(params[:id])
    else
      current_user.favorite_topic(params[:id])
    end

    redirect_to post_path(params[:id])
  end

	# def destroy
	# 	@post.destroy
	# 	redirect_to root_path
	# end

	# private 
	# 	def correct_user
	# 		@post = current_user.posts.find_by(id: params[:id])
	# 		redirect_to root_path if @post.nil?
	# 	end

end
