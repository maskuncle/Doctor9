//
//  ADWebViewController.m
//  Doctor9
//
//  Created by 何冠颉 on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "ADWebViewController.h"

@interface ADWebViewController ()<WKNavigationDelegate>

@end

@implementation ADWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    [self.webView setNeedsUpdateConstraints];
    
    CGFloat progressBarHeight = 2.f;
    _webProgressView = [[GJWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, progressBarHeight)];
    _webProgressView.progressBarColor = [UIColor orangeColor];
    _webProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_webProgressView];
    
}
#pragma mark - WebView Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.webProgressView setProgress:0 animated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
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
