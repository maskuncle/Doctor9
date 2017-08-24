//
//  SplashViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "SplashViewController.h"
#import "GuideView.h"

@interface SplashViewController () <UIScrollViewDelegate,GuideViewDelegate>

@property (nonatomic, strong)   GuideView *guideView;
@property (nonatomic, weak)     NSTimer *timer;
@property (nonatomic, strong)   UIButton *skipBtn;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //根据版本信息判断是否显示三张首页提示图片
    if([self judgeVesionChange]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"intro_screen_viewed"]) {
            self.guideView = [[GuideView alloc] initWithFrame:self.view.frame];
            self.guideView.delegate = self;
            [self.view addSubview:self.guideView];
        }
    }else{
        
    }
}

//判断版本
-(BOOL)judgeVesionChange{
    NSString *ver1 = [ConfigUtil getVersion];
    NSString *ver2 = [ConfigUtil getAppVersion];
    if (ver1 == nil) {
        [ConfigUtil setVersion:ver2];
        return YES;
    }
    if (![ver1 isEqualToString:ver2]) {
        [ConfigUtil setVersion:ver2];
        return YES;
    }
    return NO;
}

-(UIButton *)skipBtn{
    if (_skipBtn == nil) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - SkipBtnWidth - SkipRightEdging, SkipTopEdging, SkipBtnWidth, SkipBtnHeight);
        _skipBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        _skipBtn.titleLabel.textColor = [UIColor whiteColor];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _skipBtn.alpha = 0.92;
        _skipBtn.layer.cornerRadius = 4.0;
        _skipBtn.clipsToBounds = YES;
    }
    return _skipBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
