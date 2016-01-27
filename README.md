# 《两个》

一个走心的APP    
山寨了《一个》的《两个》233333哈哈哈哈  

##功能
###视频演示请看“演示.mp4”
能定期推送两句话，两篇文章，两张图片，两个问题与精妙回答    
推荐者是JCZ和GZF  
* 首页：APP介绍
* 文章：每天两篇好文章，给你心灵鸡汤
* 问题：有趣的问题有趣的回答
* 图片：自然景观，人文情怀，艺术瑰宝···
* 设置：可以切换推荐者以及切换皮肤(夜间模式)
* P.S：有点赞按钮，但是点赞按钮没有向《一个》一样可以访问数据库。  

##代码结构
####view   
PictureView:图片界面  
ReadingView:文章界面  
QuestionView:问题界面  
   
####Model   
PictureEntity:图片模型  
QuestionEntity:问题模型  
ReadingEntity:文章模型  
    
###Controller    
ViewController：首页   
PictureController：图片界面控制，包括数据获取，翻页动画等 
QuestionController：问题界面控制，包括数据获取，翻页动画等   
ReadingController：文章界面控制，包括数据获取，翻页动画等   
SettingTableViewController：设置界面   
HttpOperation：网络操作   

##使用说明  
由于未能租用成功服务器，所以无法在真机上跑，只能在模拟器上跑。   
服务器代码和测试数据资源位于：https://github.com/IOS-Two/IOS-Two-Server    
运行前请在本地部署服务器，服务器为Java+Tomcat模式。   

##具体分工
详见APP首页  



