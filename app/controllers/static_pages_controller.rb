#encoding: utf-8
class StaticPagesController < ApplicationController
	layout :choose_home_page

	def home
		@posts = Post.page(params[:page]).per_page(12)
		# @posts = Post.all
		login_by_qq unless params[:code].nil?
	end

	  def new
  end

	private
		def choose_home_page
			signed_in? ? 'application' : 'home_page'
		end

		def login_by_qq
			begin
			    httpstat=request.env['HTTP_CONNECTION']
			    qq = Qq.new
			    token = qq.get_token(params[:code],httpstat)
			    qq_user_infor = qq.get_user_info(token)
			    # QQ登录操作
			    if @user = User.find_by_uid(qq_user_infor["nickname"].to_s + qq_user_infor["figureurl"].to_s)
			        sign_in_without @user
			    else
			    	# 创建新用户
					User.new do |user|
						# :uid =>qq_user_infor["nickname"].to_s + qq_user_infor["figureurl"].to_s,
						user.name = qq_user_infor["nickname"],
						# user.avatar = qq_user_infor["figureurl_2"]
						user.save!(validate: false)
					end
			    end
			    # 操作失败返回主页
			    rescue Exception =>e
			        redirect_to root_path
			  end
		end
end