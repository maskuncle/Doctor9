# Doctor9
项目基本框架搭建

## 项目结构介绍：
按文件夹功能及用处放置相关代码文件


### Public
公共文件夹，放置工程全局都可能需要调用到的代码

1.  Base

存放基类文件，新建ViewController、Model、DB等需要继承里面的类。
2. Network

该工程使用AFNetworking框架做网络请求使用，当研发的功能使用到请求时，需要在文件夹下创建相关的类别来集成使用（例：Launch）
3. Config

a)AppConfig     app或机型信息配置 

b)ConfigUtil    app或机型信息配置+ NSUserDefaults的key-value 

c)PubFunc       工程中一些方便操作的“+方法”


### Launch -启动功能（MVC开发结构、偶尔会参入单例模式）
以下两个都是用GJLaunchViewManager进行控制：

1.引导图   在GuideView里进行图片设置

2.广告页   ShowADView

### TabBar -主页结构
- 可以在Appdelegate或GJTabBarController里查看代码

- 可以设置中间凸起等多种风格的TabBar

### Resource
音频、视频、图片（具有@、@2X、@3X的图片可放置到Assets里）
