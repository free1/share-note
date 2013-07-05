module SessionsHelper
	def sign_in(user)
		if params[:remember_me]
			cookies.permanent[:remember_token] = user.remember_token
		else
			cookies[:remember_token] = user.remember_token
		end
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

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def signed_in?
		!current_user.nil?
	end
end
