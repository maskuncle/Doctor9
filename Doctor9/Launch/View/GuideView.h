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
-(void)onDoneButtonPressed;

@end

@interface GuideView : UIView
@property id<GuideViewDelegate> delegate;

@end
