#encoding: utf-8
module SessionsHelper
	# 普通用户登录
	def sign_in(user)
		if params[:remember_me]
			cookies.permanent[:remember_token] = user.remember_token
		else
			cookies[:remember_token] = user.remember_token
		end
		self.current_user = user
	end

	# 外部帐号登录
	def sign_in_without(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

    # setter
	def current_user=(user)
		@current_user = user
	end
	# getter
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
	end
    # 判断是否为当前用户
	def current_user?(user)
		user == current_user
	end
	# 用户退出
	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
	# 是否登录
	def signed_in?
		!current_user.nil?
	end
	# 已登录用户(设置权限)
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "请先登录!"
		end
	end

	# 友好跳转
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	def store_location
		session[:return_to] = request.fullpath
	end

end
