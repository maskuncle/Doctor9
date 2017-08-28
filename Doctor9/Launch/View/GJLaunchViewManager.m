//
//  GJLaunchViewManager.m
//  Doctor9
//
//  Created by heguanjie on 17/8/28.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "GJLaunchViewManager.h"
#import "ADWebViewController.h"
#import "GuideView.h"
#import "ShowADView.h"

@interface GJLaunchViewManager ()
@property (nonatomic, strong) GuideView *guideView;
@property (nonatomic, strong) ShowADView *showADView;
@end

@implementation GJLaunchViewManager
+(instancetype)launchViewManger
{
    return [[[ self class]alloc]init];
}

-(void)showView:(UIView *)view
{
    self.frame=view.bounds;
    [view addSubview:self];
//    [self addShowADView];
//    [self loadData];
}

- (void)addShowADView{
    
}

- (void)addGuidView{
//    self.guideView = [[GuideView alloc] initWithFrame:self.view.frame];
//    self.guideView.delegate = self;
//    [self addSubview:self.guideView];
}

@end
