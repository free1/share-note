Node::Application.routes.draw do

  # 首页
  root to: 'static_pages#home'

  # github登录
  match "/auth/:provider/callback", :to => 'omniauths#create'

  # qq登录
  resources :users do
    collection do
      get 'qqlogin'
    end
  end

  #发布内容，评论
  resources :posts do
    resources :comments
  end 

  # 用户及用户关注
  resources :users do
    member do
      get :following, :followers
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
