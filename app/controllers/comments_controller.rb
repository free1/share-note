class CommentsController < ApplicationController
	before_filter :signed_in_user, only: :create
	before_filter :find_post
	before_filter :find_comment, only: [ :edit, :update, :destroy ]
	
	def create
		@comment = @post.comments.build(params[:comment])
		@comment.commenter = current_user.name
    @comment.user_id = current_user.id
		@comment.save!
		redirect_to post_path(@post)
	end

	def edit
	end

	def update
		if @comment.update_attributes(params[:comment])
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to post_path(@post)
	end

	private

		def find_post
			@post = Post.find(params[:post_id])
		end

		def find_comment
			@comment = @post.comments.find(params[:id])
		end

end
