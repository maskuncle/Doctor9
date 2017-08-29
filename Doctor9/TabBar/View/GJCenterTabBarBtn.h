//
//  GJCenterTabBarBtn.h
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJTabBarConfig.h"

#define BULGEH 16   //button bulge of height

@interface GJCenterTabBarBtn : UIButton

/** Whether center button to bulge */
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;

@end
