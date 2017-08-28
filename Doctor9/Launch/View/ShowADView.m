//
//  ShowADView.m
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "ShowADView.h"

@implementation ShowADView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //广告图片
        _ADImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:_ADImageView];
        _ADImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ADImageViewPress:)];
        [_ADImageView addGestureRecognizer:singleTap];
        
        //跳过按钮
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_skipBtn];
        _skipBtn.frame = CGRectMake(CGRectGetWidth(frame) - SkipBtnWidth - SkipRightEdging, SkipTopEdging, SkipBtnWidth, SkipBtnHeight);
        [_skipBtn addTarget:self action:@selector(SkipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _skipBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [_skipBtn setTitle:[NSString stringWithFormat:@" 跳过  %ds",SkipBtnTime] forState:UIControlStateNormal];
        _skipBtn.titleLabel.textColor = [UIColor whiteColor];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _skipBtn.alpha = 0.92;
        _skipBtn.layer.cornerRadius = 4.0;
        _skipBtn.clipsToBounds = YES;
        
        //倒计时
        _timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
        [_timer fire];
    }
    return self;
}

-(void)ADImageViewPress:(id)sender{
    if ([self.delegate respondsToSelector:@selector(onADImageViewPress:)]) {
        [self.delegate onADImageViewPress:sender];
    }
}

-(void)SkipButtonPressed:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
    if ([self.delegate respondsToSelector:@selector(onSkipButtonPressed:)]) {
        [self.delegate onSkipButtonPressed:sender];
    }
}

- (void)timeChange:(id)time {
    static int i = SkipBtnTime;
    if (i < 0) {
        i = 0;
    }
    NSString *str = [NSString stringWithFormat:@" 跳过  %ds",i ];
    [self.skipBtn setTitle:str forState:UIControlStateNormal];
    if (i <= 0) {
        [_timer invalidate];
        _timer = nil;
        if ([self.delegate respondsToSelector:@selector(onSkipButtonPressed:)]) {
            [self.delegate onSkipButtonPressed:nil];
        }
    }
    i --;
}

@end
