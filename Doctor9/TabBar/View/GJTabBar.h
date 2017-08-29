//
//  GJTabBar.h
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJCenterTabBarBtn.h"
@class GJTabBarButton;
@class GJTabBar;

@protocol GJTabBarDelegate <NSObject>
@optional
/*! 中间按钮点击会通过这个代理通知你通知 */
- (void)tabbar:(GJTabBar *)tabbar clickForCenterButton:(GJCenterTabBarBtn *)centerButton;
/*! 默认返回YES，允许所有的切换，不过你通过TabBarController来直接设置SelectIndex来切换的是不会收到通知的。 */
- (BOOL)tabBar:(GJTabBar *)tabBar willSelectIndex:(NSInteger)index;
/*! 通知已经选择的控制器下标。 */
- (void)tabBar:(GJTabBar *)tabBar didSelectIndex:(NSInteger)index;
@end

@interface GJTabBar : UIView
/** tabbar按钮显示信息 */
@property(copy, nonatomic) NSArray<UITabBarItem *> *items;
/** 其他按钮 */
@property (strong , nonatomic) NSMutableArray <GJTabBarButton*>*btnArr;
/** 中间按钮 */
@property (strong , nonatomic) GJCenterTabBarBtn *centerBtn;
/** 委托 */
@property(weak , nonatomic) id<GJTabBarDelegate>delegate;

@end
