//
//  SplashViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "SplashViewController.h"
#import "GuideView.h"
#import "ADWebViewController.h"
#import "NetworkRequester+Launch.h"

@interface SplashViewController () <UIScrollViewDelegate,GuideViewDelegate>

@property (nonatomic, strong)   GuideView *guideView;

//可提取出做单例的View
@property (nonatomic, strong)   UIView *showADView;
@property (nonatomic, strong)   UIImageView *ADImageView;
@property (nonatomic, strong)   NSTimer *timer;
@property (nonatomic, strong)   UIButton *skipBtn;
@property (strong, nonatomic)   UIPageControl *pageControl;

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
            _ADImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
            [_ADImageView setImage:[UIImage imageWithContentsOfFile:_localImagePath]];
            [self.view addSubview:_ADImageView];
            _ADImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ADImageViewPress)];
            [_ADImageView addGestureRecognizer:singleTap];
            
            [self.view addSubview:self.skipBtn];
            
            [self getSaveData];
            [self setTime];
            
        } else {
            [_showADView setHidden:true];
            [self delayMethod:nil];
        }
    }
    
}

- (void)delayMethod:(id)sender {
    UIViewController *topVc = [self.navigationController topViewController];
    if ([topVc isKindOfClass:[SplashViewController class]]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self performSegueWithIdentifier:@"to_tabbar" sender:self];
    }
}

- (void)setTime
{
    _timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
    
}

- (void)timeChange:(id)time {
    static int i = 3;
    if (i < 0) {
        i = 0;
    }
    
    NSString *str = [NSString stringWithFormat:@"%ds 跳过 ",i ];
    [self.skipBtn setTitle:str forState:UIControlStateNormal];
    [self.skipBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    if (i <= 0) {
        [self skipBtnClick:nil];
    }
    i --;
}

-(void)ADImageViewPress{
//    if ([_ADLinkUrlOld rangeOfString:@"type=app"].location != NSNotFound) {
//        //跳转到商品详情
//    }else{
        ADWebViewController *view = [[ADWebViewController alloc]initWithNibName:@"ADWebView" bundle:nil];
        view.url = _ADLinkUrlOld;
        [self.navigationController pushViewController:view animated:YES];
//    }
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

-(void)getSaveData{
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
//    NSLog(@"_____________ _ADImageUrlNew = %@", _ADImageUrlNew);
//    NSLog(@"_____________ _ADImageUrlOld = %@", _ADImageUrlOld);
    
    return nil;
}

-(NSString *)getDownloadImgPath{
    NSMutableString *sb = [NSMutableString stringWithString:[ConfigUtil getMyDataPath]];
    [sb appendString:@"/ADImage.jpg"];
    return sb;
}

-(BOOL)judgeImageExist{
    _localImagePath = [self getDownloadImgPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool ret = [fileManager fileExistsAtPath:_localImagePath];
    return ret;
}

-(void)downloadADImage{
    [NetworkRequester down:_ADImageUrlNew Local_:_localImagePath completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error != nil){
            NSLog(@"---- 下载广告网址失败！");
            NSLog(@"--- down error = %@",error);
        }else{
            NSLog(@"---- 下载广告网址成功！");
        }
    }];
}

-(void)delayEnter{
    [self delayMethod:nil];
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
        [_skipBtn addTarget:self action:@selector(skipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)skipBtnClick:(id)sender {
    [self.timer invalidate];
    [self delayMethod:nil];
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