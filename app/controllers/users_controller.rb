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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # if params[:user][:password].blank?
    #   params[:user].delete(:password)
    #   params[:user].delete(:password_confirmation)
    # end
    if @user.update_attributes(params[:user])
      flash[:success] = "更新资料成功!"
      sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

end
