//
//  ShowADView.h
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

//倒计时
#define SkipBtnTime 3
//跳过按钮宽
#define SkipBtnWidth 65
//跳过按钮高
#define SkipBtnHeight 30
//跳过按钮右边距
#define SkipRightEdging 20
//跳过按钮顶部边距
#define SkipTopEdging 40

#import <UIKit/UIKit.h>
@protocol ShowADViewDelegate <NSObject>
@optional
-(void)onSkipButtonPressed:(id)sender;
-(void)onADImageViewPress:(id)sender;

@end

@interface ShowADView : UIView
@property (nonatomic, strong) UIImageView   *ADImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) UIButton      *skipBtn;

@property id<ShowADViewDelegate> delegate;

@end
