#encoding: utf-8
class RelationshipsController < ApplicationController
	before_filter :signed_in_user

	# 创建关注关系
	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
		# 创建关注提醒
		@user.notifications.create(unread: true)
	end

	# 取消关注关系
	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
		# 取消关注删除关注提醒
		Notification.where(user_id: @user.id).delete_all
	end

end
