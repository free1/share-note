## 未完成功能
用户系统
--------------------------------------
* QQ, 微博等外部帐号登录
* 用户邀请
* 用户喜好标签
* 搜索用户
* 向下拉显示加载用户
* 将用户注册添加ajax
* 可选的用户关注提醒(站内通知)

信息发布功能
--------------------------------------
* 索到的结果高亮显示(js)
* 标记已经读过的信息
* RSS, 订阅
* 好文章置顶
* 私密share功能
* 支付功能
* 发布share可选同步到新浪微博
* 提取文章摘要及图片
* 向下拉显示加载文章

评论功能
---------------------------------------
* 用户使用“@replies” 的格式进行回复(前段)
* 定位“＃楼层”回复
* 私信
* 评论过滤垃圾词汇
* 添加ip识别
* 向下拉显示加载评论
* 添加评论使用ajax

通用功能
---------------------------------------
* 访问不存在页面404
* 访问错误id抛异常

已完成功能
---------------------------------------
* email登录(记住我)，email注册(自动登录)
* github登录
* 密码重置，注册邮件
* 用户显示，编辑，关注，签到，评论提醒，关注提醒等
* 文章发布，显示，编辑，分类，收藏，赞，删除，访问量等
* 评论显示，回复，编辑，删除，@等
* 管理员权限，管理员可以删除所有用户，文章和评论
* 一号为超级管理员，可以设置其他用户为管理员
* 管理员列表显示

正在完成功能
---------------------------------------
* 管理员可以控制用户发表文章，评论权限
* 管理员可以单独查看一些功能(所有文章列表，评论等)

未解决已知bug
----------------------------------------
* 首页功能(未登录首页去掉登录框)重写
* 连续点击签到以后显示今天已经签到的flash
* github登录欢迎信息在首页一直不消失
* time_ago_in_word(发表时间与当前时间对比)重写
* 空搜索后总提示“请输入您要查找的内容！”
* github登录头像设置不上
* 当使用email注册用户后，再使用github登陆相同的用户会报错
* 重置密码时，显示了原来的秘文密码
