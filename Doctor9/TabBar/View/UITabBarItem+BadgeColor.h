//
//  UITabBarItem+BadgeColor.h
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITabBarItem (BadgeColor)
@property (nonatomic, readwrite, copy, nullable) UIColor *badgeColor;

@end
