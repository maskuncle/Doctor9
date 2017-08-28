//
//  SplashViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "SplashViewController.h"
#import "GuideView.h"
#import "ShowADView.h"
#import "ADWebViewController.h"
#import "NetworkRequester+Launch.h"
#import "GJTabBarController.h"

@interface SplashViewController () <UIScrollViewDelegate,GuideViewDelegate,ShowADViewDelegate>

@property (nonatomic, strong)   GuideView *guideView;
@property (nonatomic, strong)   ShowADView *showADView;

//可做广告的Model
@property (nonatomic, strong)   NSString *ADImageUrlOld;
@property (nonatomic, strong)   NSString *ADLinkUrlOld;
@property (nonatomic, strong)   NSString *lastImgTagOld;
@property (nonatomic, strong)   NSString *ADImageUrlNew;
@property (nonatomic, strong)   NSString *ADLinkUrlNew;
@property (nonatomic, strong)   NSString *lastImgTagNew;
@property (nonatomic, strong)   NSString *localImagePath;
@property (nonatomic, assign)   BOOL bParseOld;
@property (nonatomic, assign)   BOOL isEmpty;

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
        [self loadData];
        
        //判断是否有广告
        if ([self judgeImageExist]) {
            self.showADView = [[ShowADView alloc] initWithFrame:self.view.frame];
            [self.showADView.ADImageView setImage:[UIImage imageWithContentsOfFile:_localImagePath]];
            self.showADView.delegate = self;
            [self.view addSubview:self.showADView];
            
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
            
        } else {
            [_showADView setHidden:true];
            [self delayMethod:nil];
        }
    }
    
}

-(void)dealloc{
    NSLog(@"--- dealloc SplashVC");
}

- (void)delayMethod:(id)sender {
    NSLog(@"---- PubFunc getCurrentVC = %@",[PubFunc getCurrentVC]);
    if ([[PubFunc getCurrentVC] isKindOfClass:[SplashViewController class]]) {
        GJTabBarController *tabBarController = [[GJTabBarController alloc] init];
        tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tabBarController animated:YES completion:^{}];
    }
}

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
        [self parseADList:responseObject];
        if (_isEmpty) {
            NSError *err;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:_localImagePath error:&err];
        }
        if ([_lastImgTagOld isEqualToString:_lastImgTagNew] || _ADImageUrlNew == nil) {
            return;
        }
        [self downloadADImage];
        
    } fail:^(NSError *error) {
        
    }];
    
}

-(NSMutableArray *)parseADList:(id)jsonObject{
    if ([jsonObject isKindOfClass:[NSArray class]]){
        NSArray *deserializedArray = (NSArray *)jsonObject;
        
        if (0 == [deserializedArray count]) {
            _isEmpty = true;
            return nil;
        }
        
        _isEmpty = false;
        id ob = [deserializedArray objectAtIndex:0];
        
        if (_bParseOld) {
            _ADImageUrlOld = [ob objectForKey:@"img_url"];
            _lastImgTagOld = [ob objectForKey:@"img_etag"];
            _ADLinkUrlOld = [ob objectForKey:@"link_url"];
        }else{
            _ADImageUrlNew = [ob objectForKey:@"img_url"];
            _lastImgTagNew = [ob objectForKey:@"img_etag"];
            _ADLinkUrlNew = [ob objectForKey:@"link_url"];
        }
    } else {
        NSLog(@"An error happened while deserializing the JSON data.");
    }
    NSLog(@"_____________ _ADImageUrlNew = %@", _ADImageUrlNew);
    NSLog(@"_____________ _ADImageUrlOld = %@", _ADImageUrlOld);
    
    return nil;
}

-(BOOL)judgeImageExist{
    NSMutableString *sb = [NSMutableString stringWithString:[ConfigUtil getMyDataPath]];
    [sb appendString:@"/ADImage.jpg"];
    _localImagePath = sb;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool ret = [fileManager fileExistsAtPath:_localImagePath];
    return ret;
}

-(void)downloadADImage{
    [NetworkRequester down:_ADImageUrlNew Local_:_localImagePath completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
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

#pragma mark - GuideViewDelegate
//点击‘开始体验’
-(void)onDoneButtonPressed{
    [self delayMethod:nil];
}

#pragma mark - ShowADViewDelegate
 //点击‘跳转’按钮
-(void)onSkipButtonPressed:(id)sender{
    [self delayMethod:nil];
}
 //点击广告图片
-(void)onADImageViewPress:(id)sender{
    ADWebViewController *vc = [[ADWebViewController alloc] init];
    if (_ADLinkUrlOld == nil) {
        vc.url = _ADLinkUrlNew;
    }else{
        vc.url = _ADLinkUrlOld;
    }
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:^{}];
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
