#encoding: utf-8
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "恭喜你注册帐号成功！"
  		redirect_to root_path
  	else
  		render 'new'	
  	end
  end

end
