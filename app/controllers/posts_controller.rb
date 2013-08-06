class PostsController < ApplicationController

	def show
		@post = Post.find(params[:id])
		@comment = @post.comments.build
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

end
