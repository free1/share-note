#encoding: utf-8
class UsersController < ApplicationController
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :signed_in_user,
                only: [ :edit, :update, :destroy, :following, :followers ]

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def following
    @title = "收看"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "观众"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # 用户只能修改自己的资料
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end


end















