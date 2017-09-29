//
//  BaseWKWebViewController.h
//  MoxaYS
//
//  Created by heguanjie on 17/9/13.
//  Copyright © 2017年 jiudaifu. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

#define NAVI_HEIGHT     64

@interface BaseWKWebViewController : BaseViewController <UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) WKWebView *wk_WebView;
@property (nonatomic, strong) UIWebView *webView;


@property (nonatomic, strong) UIProgressView *loadingProgressView;
@property (nonatomic, strong) UIButton *reloadButton;

@property (nonatomic, assign) BOOL canDownRefresh;

- (void)createNaviItem;

- (void)loadRequest;

@end
