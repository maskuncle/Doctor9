//
//  GJLaunchViewManager.m
//  Doctor9
//
//  Created by heguanjie on 17/8/28.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "GJLaunchViewManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GJLaunchViewManager () <GuideViewDelegate,ShowADViewDelegate>
@property (nonatomic, strong) GuideView *guideView;
@property (nonatomic, strong) ShowADView *showADView;

@property (nonatomic, strong)   NSString *localImagePath;   //图片下载至本地的地址

@property (nonatomic, assign)   BOOL bParseOld;
@property (nonatomic, strong)   GJAdModel *adModelOld;
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
    [self judgeShowAndLoad];
    [self loadData];
}

- (void)judgeShowAndLoad{
    //根据版本信息判断是否显示三张首页提示图片
    if([self judgeVesionChange]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"intro_screen_viewed"]) {
            self.guideView = [[GuideView alloc] initWithFrame:self.bounds];
            self.guideView.delegate = self;
            [self addSubview:self.guideView];
        }
    }else{
        //判断是否有广告
        if ([self judgeImageExist]) {
            self.showADView = [[ShowADView alloc] initWithFrame:self.bounds];
            self.showADView.delegate = self;
            [self addSubview:self.showADView];
            if (![PubFunc isEmpty:_adModel.img_url]) {
                [self.showADView.ADImageView sd_setImageWithURL:[NSURL URLWithString:_adModel.img_url] placeholderImage:nil];
            }else{
                [self.showADView.ADImageView setImage:[UIImage imageWithContentsOfFile:self.localImagePath]];
                NSDictionary *dic = [ConfigUtil getADimg];
                if (dic != nil) {
                    _bParseOld = true;
                    @try {
                        [self parseADList:dic];
                    }
                    @catch (NSException *exception) {
                        NSLog(@"__________ %@", exception);
                    }
                }
            }
            
        } else {
            [_showADView setHidden:true];
            [self dismissController];
        }
    }

}

//从灸大夫服务器上取下来的广告数据Model
-(void)loadData{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat scalc_screen = [UIScreen mainScreen].scale;
    CGFloat width = size.width * scalc_screen;
    CGFloat height = size.width * scalc_screen;
    
    [NetworkRequester getAppStartupAd:width MainSreenH:height success:^(id responseObject) {
        NSLog(@"---getAppStartupAd responseObject = %@",responseObject);
        [ConfigUtil setADimg:responseObject];
        _bParseOld = false;
        if ([self parseADList:responseObject]) {
            NSError *err;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:self.localImagePath error:&err];
        }
        if ([_adModelOld.img_etag isEqualToString:_adModel.img_etag] || _adModel.img_url == nil) {
            return;
        }
        [self downloadADImage];
        
    } fail:^(NSError *error) {
        
    }];
    
}

- (BOOL)parseADList:(id)jsonObject{
    if ([jsonObject isKindOfClass:[NSArray class]]){
        NSArray *deserializedArray = (NSArray *)jsonObject;
        if (0 == [deserializedArray count]) {
            return true;
        }
        id ob = [deserializedArray objectAtIndex:0];
        
        if (_bParseOld) {
            _adModelOld = [[GJAdModel alloc] init];
            _adModelOld.img_url = [ob objectForKey:@"img_url"];
            _adModelOld.img_etag = [ob objectForKey:@"img_etag"];
            _adModelOld.link_url = [ob objectForKey:@"link_url"];
            
        }else if(_adModel == nil){
            _adModel = [[GJAdModel alloc] init];
            _adModel.img_url = [ob objectForKey:@"img_url"];
            _adModel.img_etag = [ob objectForKey:@"img_etag"];
            _adModel.link_url = [ob objectForKey:@"link_url"];
        }
    } else {
        NSLog(@"An error happened while deserializing the JSON data.");
    }
//    NSLog(@"_____________ _ADImageUrlNew = %@", _ADImageUrlNew);
//    NSLog(@"_____________ _ADImageUrlOld = %@", _ADImageUrlOld);
    
    return false;
}

-(BOOL)judgeImageExist{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool ret = [fileManager fileExistsAtPath:self.localImagePath];
    return ret;
}

-(NSString *)localImagePath{
    if (_localImagePath == nil) {
        NSMutableString *sb = [NSMutableString stringWithString:[ConfigUtil getMyDataPath]];
        [sb appendString:@"/ADImage.jpg"];
        _localImagePath = sb;
    }
    return _localImagePath;
}

-(void)downloadADImage{
    [NetworkRequester down:_adModel.img_url Local_:self.localImagePath completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error != nil){
            NSLog(@"---- 下载广告网址失败！");
            NSLog(@"--- down error = %@",error);
        }
    }];
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

- (void)cancleNSTimer{
    if (self.showADView.timer) {
        [self.showADView.timer invalidate];
        self.showADView.timer = nil;
    }
}

- (void)dismissController {
    [self cancleNSTimer];
    //消失动画
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //缩放修改处
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - GuideViewDelegate
//点击‘开始体验’
-(void)onDoneButtonPressed{
    [self dismissController];
}

#pragma mark - ShowADViewDelegate
//点击‘跳转’按钮
-(void)onSkipButtonPressed:(id)sender{
    [self dismissController];
}
//点击广告图片
-(void)onADImageViewPress:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        ADWebViewController *adVc = [[ADWebViewController alloc] init];
        if ([PubFunc isEmpty:_adModelOld.link_url]) {
            adVc.url = _adModel.link_url;
        }else{
            adVc.url = _adModelOld.link_url;
        }
//        adVc.hidesBottomBarWhenPushed=YES;
//        adVc.tabBarController.tabBar.hidden = YES;
        [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0] pushViewController:adVc animated:NO];
        [self removeFromSuperview];
    });
}

@end
