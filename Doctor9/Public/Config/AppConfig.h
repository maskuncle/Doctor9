//
//  AppConfig.h
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


// debug打印信息，release不打印信息
#ifdef __OPTIMIZE__
# define NSLog(...) {}
#else
# define NSLog(...) NSLog(__VA_ARGS__)
#endif

// 沙盒路径
#define SysDocumentsPath    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

// 机型
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IOS_7        ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define SCREEN_WID      ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEI      ([[UIScreen mainScreen] bounds].size.height)
#define STATUS_HEI      ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define BOTTOMBAR_HEI   49
#define NAVBAR_HEI      (self.navigationController.navigationBar.frame.size.height)

//颜色和透明度设置
#define RGBA(r,g,b,a)   [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define NORMAL_BTN_COLOR    RGBA(0x00, 0x97, 0xea, 1)
#define PRESSED_BTN_COLOR   RGBA(0xd0, 0xcf, 0xcf, 1)
#define BTN_BORDER_COLOR    RGBA(0xaa, 0xaa, 0xaa, 1)

#define GRADIENT_START_COLOR    RGBA(0xff, 0xff, 0xff, 1)
#define GRADIENT_END_COLOR      RGBA(0xdd, 0xdd, 0xdd, 1)

#define CARE_NORMAL_BTN_COLOR    RGBA(0xFF, 0x69, 0x87, 1)
#define CARE_PRESSED_BTN_COLOR   RGBA(0xd0, 0xcf, 0xcf, 1)

#endif /* AppConfig_h */
