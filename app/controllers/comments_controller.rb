class CommentsController < ApplicationController
	before_filter :signed_in_user, only: :create
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params[:comment])
		@comment.commenter = current_user.name
		@comment.save!
		redirect_to post_path(@post)
	end

end
