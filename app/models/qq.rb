#encoding=utf-8
#以下不需要改动
AUTHURL='https://graph.qq.com/oauth2.0/authorize?'
TOKENURL='https://graph.qq.com/oauth2.0/token?'
OPENIDURL='https://graph.qq.com/oauth2.0/me?access_token='
GETUSERINFOURL='https://graph.qq.com/user/get_user_info?'

require 'rubygems'
require 'net/http'
require 'uri'
require 'open-uri'
require 'rest-client'
require 'multi_json'

# QQ登录类
class Qq
	APPID = '100533871'
	APPKEY = '5e7bb6b1e0a0a901045be70e1cb99fcc'
	REDURL = '&redirect_uri='

	# 需要在本类中的其他方法中调用设置成实例变量
	attr_reader :token, :openid, :auth

	#点击登陆按钮跳转地址
	def Qq.redo(scope)
		AUTHURL + 'response_type=code&client_id='+ APPID + REDURL + '&scope=' + scope
	end

	#获取令牌:认证码code=params[:code],httpstat=request.env['HTTP_CONNECTION']
	def get_token(code,httpstat)
		#获取令牌
        @token=open(TOKENURL + 'grant_type=authorization_code&client_id=' + 
        			APPID + '&client_secret=' + APPKEY + '&code=' + code + 
        			'&state='+ httpstat + REDURL,
                    :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read[/(?<=access_token=)\w{32}/]
        #获取Openid
        @openid=open(OPENIDURL + @token,
        			:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read[/\w{32}/]
        #获取通用验证参数
        @auth='access_token=' + @token + '&oauth_consumer_key=' + APPID + '&openid=' + @openid
	end

	#获取用户信息:比如figureurl,nickname
	def get_user_info(auth)
		MultiJson.decode(open(GETUSERINFOURL + auth,
			:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read.force_encoding('utf-8'))
	end
end
