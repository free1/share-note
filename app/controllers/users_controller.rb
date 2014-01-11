#encoding: utf-8
class UsersController < ApplicationController
  before_filter :correct_user, only: [ :edit, :update ]
  before_filter :signed_in_user,
                only: [ :index, :edit, :update, :destroy, :following, :followers, :favorite ]
  before_filter :admin, only: :destroy

  def index
    @users = User.page(params[:page])
    @super_admin = User.find(1)
  end

  def show
    @user = User.find(params[:id])
    @super_admin = User.find(1)
    @posts = @user.posts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      # 注册邮件提醒
      SignupMailer.send_signup_mailer(@user).deliver
      flash[:success] = "Welcome #{@user.name}"
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除"
    redirect_to users_path
  end

  # 显示关注
  def following
    @title = "关注"
    @user = User.find(params[:id])
    @users = @user.followed_users.page(params[:page]).per_page(12)
    render 'show_follow'
  end

  # 显示粉丝
  def followers
    @title = "粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per_page(12)
    render 'show_follow'
  end

  # QQ登录
  def qqlogin
    redirect_to Qq.redo("get_user_info")
  end

  # 显示收藏的文章
  def favorite
    @favorite_posts = Post.where(id: current_user.favorite_topic_ids.split(","))
  end

  # 签到功能
  def qiandao
    # 如果数据库没有签到数据则创建一条防止nil
    if current_user.qiandaos == []
      current_user.qiandaos.create(qiandao_day_count: 0, qiandao_day_time: 0)
    end
    @qiandao_day_count = current_user.qiandaos.last.qiandao_day_count
    @is_qiandao = Time.now.strftime('%m%d').to_i - current_user.qiandaos.last.qiandao_day_time
    render 'qiandao_execute'
  end
  # 执行签到功能
  def qiandao_execute
    @qiandao_day_count = current_user.qiandaos.last.qiandao_day_count
    @is_qiandao = Time.now.strftime('%m%d').to_i - current_user.qiandaos.last.qiandao_day_time

    now_time = Time.now.strftime('%m%d').to_i
    continuous_day = now_time. - current_user.qiandaos.last.qiandao_day_time
    # 用时间判断是否连续签到
    if continuous_day == 1
      # 昨天签过到
      qiandao_day_count = current_user.qiandaos.last.qiandao_day_count + 1
      current_user.qiandaos.create(qiandao_day_count: qiandao_day_count, qiandao_day_time: now_time)
    elsif continuous_day == 0
      # 连续点击签到无效
      flash[:error] = "今天已经签到了哦!"
    else
      # 没有连续签到或首次签到
      current_user.qiandaos.create(qiandao_day_count: 1, qiandao_day_time: now_time)
    end
    redirect_to qiandao_user_path(current_user)
  end


  # 超级管理员设置管理员
  def set_admin
    user = User.find(params[:id])
    if user.toggle!(:admin)
      redirect_to user
    else
      flash[:error] = "设置失败！"
      redirect_to root_path
    end
  end

  private
    # 用户只能修改自己的资料
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin
      redirect_to(root_path) unless current_user.admin?
    end
end
