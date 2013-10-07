#encoding=utf-8
#以下不需要改动
AUTHURL='https://graph.qq.com/oauth2.0/authorize?'
TOKENURL='https://graph.qq.com/oauth2.0/token?'
OPENIDURL='https://graph.qq.com/oauth2.0/me?access_token='
GETUSERINFOURL='https://graph.qq.com/user/get_user_info?'
ADDSHAREURL='https://graph.qq.com/share/add_share'
CHECKPAGEFANSURL='https://graph.qq.com/user/check_page_fans?'
ADDTURL='https://graph.qq.com/t/add_t'
ADDPICTURL='https://graph.qq.com/t/add_pic_t'
DELTURL='https://graph.qq.com/t/del_t'
GETREPOSTLISTURL='https://graph.qq.com/t/get_repost_list?'
GETINFOURL='https://graph.qq.com/user/get_info?'
GETOTHERINFOURL='https://graph.qq.com/user/get_other_info?'
GETFANSLISTURL='https://graph.qq.com/relation/get_fanslist?'
GETIDOLLISTURL='https://graph.qq.com/relation/get_idollist?'
ADDIDOLURL='https://graph.qq.com/relation/add_idol'
DELIDOLURL='https://graph.qq.com/relation/del_idol'

require 'rubygems'
require 'net/http'
require 'uri'
require 'open-uri'
require 'rest-client'
require 'multi_json'

class Qq
	APPID = '100533871'
	APPKEY = '5e7bb6b1e0a0a901045be70e1cb99fcc'
	REDURL = '&redirect_uri='

	
end