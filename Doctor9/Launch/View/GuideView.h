//
//  GuideView.h
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GuideViewDelegate <NSObject>
@optional
//点击‘开始体验’
-(void)onDoneButtonPressed;

@end

@interface GuideView : UIView
@property id<GuideViewDelegate> delegate;

@end
