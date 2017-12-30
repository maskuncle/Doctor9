//
//  AppDelegate.m
//  Doctor9
//
//  Created by 何冠颉 on 17/8/23.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "AppDelegate.h"
#import "GJTabBarController.h"
#import "GJLaunchViewManager.h"
#import "MainViewController.h"
#import "SecondViewController.h"
#import "MidViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "UITabBarItem+BadgeColor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self addMainWindow];
    [self addADLaunchController];
    return YES;
}

#pragma mark TabBar设置
- (void)addMainWindow{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    GJTabBarController *tabbar = [[GJTabBarController alloc] init];
    
    /**
     *  配置外观
     */
    [GJTabBarConfig shared].selectedTextColor = [UIColor orangeColor];
    [GJTabBarConfig shared].textColor = [UIColor grayColor];
    [GJTabBarConfig shared].backgroundColor = [UIColor whiteColor];
    [GJTabBarConfig shared].selectIndex = 0;
    [GJTabBarConfig shared].centerBtnIndex = 2;
    
    /**
     *  style 1 (中间按钮突出 ， 设为按钮 , 底部有文字 ， 闲鱼)
     */
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]];
    [tabbar addChildController:nav1 title:@"首页" imageName:@"Btn01" selectedImageName:@"SelectBtn01"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[SecondViewController new]];
    [tabbar addChildController:nav2 title:@"详情" imageName:@"Btn02" selectedImageName:@"SelectBtn02"];
    UINavigationController *navMid = [[UINavigationController alloc]initWithRootViewController:[MidViewController new]];
    [tabbar addCenterController:navMid bulge:YES title:@"中间" imageName:@"post_normal" selectedImageName:@"post_normal"];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:[DiscoverViewController new]];
    [tabbar addChildController:nav3 title:@"发现" imageName:@"Btn01" selectedImageName:@"SelectBtn01"];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:[MineViewController new]];
    [tabbar addChildController:nav4 title:@"我的" imageName:@"Btn02" selectedImageName:@"SelectBtn02"];
    /**
     *  set 设置tabbar的相关数据信息(红点等)
     *  例如: tabbar.tabbar.items[1].badgeColor = [UIColor orangeColor];
     *       tabbar.tabbar.items[1].badgeValue = @"1234";
     */
    
    /**
     *  style 2  (中间按钮不突出 ， 设为控制器 ,底部无文字  , 微博)
     */
//        UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]];
//        [tabbar addChildController:nav1 title:@"消息" imageName:@"tabbar_mainframe" selectedImageName:@"tabbar_mainframeHL"];
//        UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[SecondViewController new]];
//        [tabbar addChildController:nav2 title:@"朋友圈" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discoverHL"];
//        [tabbar addCenterController:[MidViewController new] bulge:NO title:nil imageName:@"tabbar_centerplus_selected" selectedImageName:@"tabbar_centerplus_selected"];
    
    /**
     *  style 3  (无中间按钮 ，普通样式)
     */
    //    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    //    [tabbar addChildController:nav1 title:@"消息" imageName:@"tabbar_mainframe" selectedImageName:@"tabbar_mainframeHL"];
    //    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    //    [tabbar addChildController:nav2 title:@"朋友圈" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discoverHL"];
    
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
}
#pragma mark 启动页的 -引导图和广告页
- (void)addADLaunchController{
    GJAdModel * adModel=[[GJAdModel alloc]init];
    adModel.img_url=@"http://d.hiphotos.baidu.com/image/pic/item/f7246b600c3387444834846f580fd9f9d72aa034.jpg";
    adModel.link_url=@"http://www.sina.com";
    
    UIViewController *rootViewController = self.window.rootViewController;
    GJLaunchViewManager *launchController = [GJLaunchViewManager launchViewManger];
    launchController.adModel = adModel;
    [launchController showView:rootViewController.view];
}

#pragma mark 其他

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
