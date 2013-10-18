Node::Application.routes.draw do

  # 首页
  root to: 'static_pages#home'
  
  # github登录
  match "/auth/:provider/callback", :to => 'omniauths#create'

  #发布内容，评论
  resources :posts do
    # 评论
    resources :comments

    # 标签
    collection do
      # 文章种类
      get 'post_kind'
    end

    # 用户文章收藏
    # member do
    #   get 'collect'
    # end
  end 

  # 用户系统
  resources :users do
    # 用户关注
    member do
      get :following, :followers
    end

    # qq登录
    collection do
      get 'qqlogin'
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
  
end
