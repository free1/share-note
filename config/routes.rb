Node::Application.routes.draw do

  # 首页
  root to: 'static_pages#home'
  
  # github登录
  match "/auth/:provider/callback", :to => 'omniauths#create'

  #发布内容，评论
  resources :posts do
    # 评论
    resources :comments

    member do
      # 文章收藏功能
      # get :favorite
      # 赞功能
      # get :zan
      # 文章收藏，赞功能
      get :topic_function
    end
    
    # 标签
    collection do
      # 文章种类
      get 'post_kind'
    end

  end 

  # 用户关系
  resources :relationships, only: [ :create, :destroy ]

  # 用户登录
  resources :sessions, only: [ :new, :create, :destroy ]
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  # 首页登录出错跳转
  match '/sessions', to: 'sessions#new'
  
  # 找回密码
  resources :password_resets
  # 重置密码
  get 'password_resets/new'
  

  # 站内通知
  resources :notifications 

  # 管理员功能
  namespace :admins do
    resources :users
  end 

  # 用户系统
  resources :users do

    member do
      # 用户关注
      get :following, :followers
      # 文章收藏(喜爱)
      get :favorite
      # 签到
      get :qiandao
      get :qiandao_execute
      # 设置管理员
      get :set_admin
    end

    collection do
      # qq登录
      get :qqlogin
    end
  end
end
