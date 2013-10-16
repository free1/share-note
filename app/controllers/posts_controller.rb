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
		@comment = @post.comments.build
		@comments = @post.comments
	end

	def new
		@post = current_user.posts.build
	end

	def create
		# 给文章打上标签方便检索
		tag = Tag.new(kind: session[:kind], language: session[:language])
		tag.save
		@post = current_user.posts.build(title: params[:post][:title], content: params[:post][:content], tag_id: tag.id)
		if @post.save
		    redirect_to post_path(@post)
		else
			# 文章创建失败就删除标签
			tag.destroy
			flash.now[:error] = "文章标题和内容都不可以为空哦！"
			render 'tag_choice'
		end
	end

	# 文章种类标签的确定
	def tag_choice
	end
	# 文章所属编程语言标签及存入数组
	def tag_custom
		@post = current_user.posts.build
		if params[:language] && params[:kind]
			session[:kind] = "#{params[:kind]}"
			session[:language] = "#{params[:language]}"
	 		render 'new' 
	 	else
	 		# render 'tag_choice'
	 	end
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
