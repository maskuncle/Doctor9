//
//  NetworkCongfig.h
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#ifndef NetworkCongfig_h
#define NetworkCongfig_h

#define  MAIN_WEB_URL           @"http://api.jiudafu.com/"  //@"http://mobile.jiudafu.com/mobile/"


// 服务端返回代码
#define ERROR_SUCCESS 0 // 成功
#define ERROR_INVALID_PARAM  -1 // 无效参数
#define ERROR_INVALID_NAME  -2 // 无效用户名
#define ERROR_INVALID_PASSWD  -3 // 无效密码
#define ERROR_NAME_EXISTED  -4 // 用户名已存在
#define ERROR_DATABASE_QUERY  -5 // 数据库查询出错
#define ERROR_CANNOT_DOWNLOAD  -6 // 用户不能下载此资源. 积分(灸币)不够
#define ERROR_MOBILE_EXISTED  -7    // 手机号码已被注册
#define ERROR_MUL_LOGON  -8 // 重复登录
#define ERROR_FILE_UPLOAD  -9 // 文件上传失败
#define ERROR_MOBILE_MSG  -10 // 短信发送失败
#define ERROR_MACHINE_EXISTED  -11 // 灸疗仪机器码已存在
#define ERROR_NOT_LOGON  -12 // 还未登录
#define ERROR_USER_COMPLAINT  -13  // 用户被投诉
#define ERROR_SAME_QUESTION  -14   // 相同问题
#define ERROR_NOT_VIP  -15		 //不是VIP
#define ERROR_HAS_CHECKIN   -16 //已经签到过
#define ERROR_UNDEFINED -17
#define ERROR_SECURITY_CODE -18 //验证码错误
#define ERROR_QUESTION_DEL   -19 //收藏的问题被删除、不可以再评论
#define ERROR_SHARE_MAX -20

#define ERROR_OTHER  -100   // 其它，具体见 msg 的内容

// 本地扩展错误代码
#define ERROR_UNKNOW  -101 // 未知错误
#define ERROR_UNKNOW_HOST  -102 // 无法连接服务器
#define ERROR_JSON  -103  // 服务端返回的json格式有误

#define HTTP_GET_SUCCESS 200 //http请求成功

#endif /* NetworkCongfig_h */
