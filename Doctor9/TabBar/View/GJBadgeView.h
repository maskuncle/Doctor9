//
//  GJBadgeView.h
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJBadgeView : UIButton
/** remind number */
@property (copy , nonatomic) NSString *badgeValue;
/** remind color */
@property (copy , nonatomic) UIColor *badgeColor;
@end
