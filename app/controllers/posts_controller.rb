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
		@post.increment(:viewed_count)                        #浏览计数器
		@comment = @post.comments.build
		@comments = @post.comments
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			redirect_to post_path(@post)
		else
			render 'new'
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
