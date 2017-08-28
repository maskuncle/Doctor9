//
//  GJLaunchViewManager.h
//  Doctor9
//
//  Created by heguanjie on 17/8/28.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJAdModel.h"

@interface GJLaunchViewManager : UIView
/** 广告模型*/
@property (nonatomic, strong) GJAdModel *adModel;
/**
 创建一个对象
 */
+(instancetype)launchViewManger;
/**
 展示对象
 */
-(void)showView:(UIView *)view;
@end
