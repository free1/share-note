class StaticPagesController < ApplicationController
  def home
  	@posts = Post.all
  end
end