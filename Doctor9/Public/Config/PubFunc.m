//
//  PubFunc.m
//  Doctor9
//
//  Created by heguanjie on 17/8/26.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "PubFunc.h"

@implementation PubFunc
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

+(BOOL)isEmpty:(NSString *)str{
    if([str isEqual:[NSNull null]] || str == nil || str.length == 0 || [str isEqualToString:@"(null)"]){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isEmpty_id:(id)obj{
    if (obj == nil) {
        return YES;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        if (array.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        if ([PubFunc isEmpty:str]) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)obj;
        if ([PubFunc isEmptyWithDic:dic]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isEmptyWithDic:(NSDictionary *)dic{
    if ((NSNull *)dic == [NSNull null]){
        return YES;
    }else if(dic.count == 0) {
        return YES;
    }else {
        return NO;
    }
}

@end
