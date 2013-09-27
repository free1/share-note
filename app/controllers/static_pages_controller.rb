class StaticPagesController < ApplicationController
	layout :choose_home_page

	def home
		@posts = Post.all
	end

	private
		def choose_home_page
			signed_in? ? 'application' : 'home_page'
		end
end