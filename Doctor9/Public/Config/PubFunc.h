//
//  PubFunc.h
//  Doctor9
//
//  Created by heguanjie on 17/8/26.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubFunc : NSObject
/*!获取当前控制器*/
+ (UIViewController *)getCurrentVC;
//为空判断
+ (BOOL)isEmpty:(NSString *)str;
+ (BOOL)isEmptyWithDic:(NSDictionary *)dic;
+ (BOOL)isEmpty_id:(id)obj;


@end
