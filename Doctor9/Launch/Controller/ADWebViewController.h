//
//  ADWebViewController.h
//  Doctor9
//
//  Created by 何冠颉 on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "BaseViewController.h"
#import "GJWebViewProgressView.h"
#import <WebKit/WebKit.h>

@interface ADWebViewController : BaseViewController
@property (nonatomic, strong)   NSString *url;
@property (nonatomic, strong)   WKWebView *webView;
@property (nonatomic, strong)   GJWebViewProgressView *webProgressView;

@end
