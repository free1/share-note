class OmniauthsController < ApplicationController

	def create
		user = User.from_auth(request.env['omniauth.auth'])

		flash[:notice] = "Welcome #{user.name}"
		redirect_to root_path
	end
end
