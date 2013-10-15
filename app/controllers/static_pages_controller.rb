#encoding: utf-8
class StaticPagesController < ApplicationController
	layout :choose_home_page

	def home
		if params[:kind]
			# 根据用户选择的种类找出文章
			@tag = params[:kind]
			@posts = @tag.posts.where(kind: params[:kind])
			render 'home'
        else
        	# 找出所有文章
		    @posts = Post.page(params[:page]).per_page(12)
		end
		# QQ登录操作
		login_by_qq unless params[:code].nil?
	end

	# def menu
	# 	if params[:kind]
 #            @tag = Tag.tag_search_posts(params[:kind])
 #            render 'home'
	# 	else
	# 		redirect_to root_path
	# 	end
	# end

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