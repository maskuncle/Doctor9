//
//  BaseWKWebViewController.m
//  MoxaYS
//
//  Created by heguanjie on 17/9/13.
//  Copyright © 2017年 jiudaifu. All rights reserved.
//

#import "BaseWKWebViewController.h"
#import "MJRefresh.h"

@interface BaseWKWebViewController ()
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property (nonatomic, strong) id <UIGestureRecognizerDelegate>delegate;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) MJRefreshHeader *refreshHeader;

@end

@implementation BaseWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    _url = @"http://www.sina.com";
    [self createWebView];
    [self setMjRefreshHeader];
//    [self createNaviItem];
//    [self loadRequest];
}

- (void)setMjRefreshHeader{
    __weak typeof(self) weakSelf = self;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        _wk_WebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf webViewReload];
        }];
    } else {
        _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf webViewReload];
        }];
    }
}
- (void)dealloc {
    [_wk_WebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wk_WebView stopLoading];
    [_webView stopLoading];
    _wk_WebView.UIDelegate = nil;
    _wk_WebView.navigationDelegate = nil;
    _webView.delegate = nil;
}

#pragma mark - 加载请求
- (void)loadRequest {
//    if (![self.url hasPrefix:@"http"]) {//是否具有http前缀
//        self.url = [NSString stringWithFormat:@"http://%@",self.url];
//    }
    NSString * htmlResponseStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:self.url] encoding:NSUTF8StringEncoding error:Nil];
    NSURLRequest *request;
    if(![PubFunc isEmpty:htmlResponseStr]){
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    }else{
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:3];
    }
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [_wk_WebView loadRequest:request];
    } else {
        [_webView loadRequest:request];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _loadingProgressView.progress = [change[@"new"] floatValue];
        if (_loadingProgressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _loadingProgressView.hidden = YES;
            });
        }
    }
}

//重新加载
- (void)webViewReload {
    [_webView reload];
    [_wk_WebView reload];
}

//加载缓存
- (void)webViewLoadCache{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:3];
    [_wk_WebView loadRequest:request];
    [_webView loadRequest:request];
}

#pragma mark - 版本适配
- (void)createWebView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.reloadButton];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [self.view addSubview:self.wk_WebView];
        [self.view addSubview:self.loadingProgressView];
    } else {
        [self.view addSubview:self.webView];
    }
}

#pragma mark - 懒加载
- (UIWebView*)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVI_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - NAVI_HEIGHT)];
        _webView.delegate = self;
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0 && _canDownRefresh) {
//            _webView.scrollView.refreshControl = self.refreshControl;
        }
    }
    return _webView;
}

- (WKWebView*)wk_WebView {
    if (!_wk_WebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [[WKPreferences alloc]init];
        config.userContentController = [[WKUserContentController alloc]init];
        _wk_WebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NAVI_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - NAVI_HEIGHT) configuration:config];
        _wk_WebView.navigationDelegate = self;
        _wk_WebView.UIDelegate = self;
        //添加此属性可触发侧滑返回上一网页与下一网页操作
        _wk_WebView.allowsBackForwardNavigationGestures = YES;
        //下拉刷新
//        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0 && _canDownRefresh) {
            //            _wk_WebView.scrollView.refreshControl = self.refreshControl;
//        }
        //进度监听
        [_wk_WebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _wk_WebView;
}

- (UIProgressView*)loadingProgressView {
    if (!_loadingProgressView) {
        _loadingProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, NAVI_HEIGHT, self.view.bounds.size.width, 2)];
        _loadingProgressView.progressTintColor = [UIColor orangeColor];
    }
    return _loadingProgressView;
}

//- (UIRefreshControl*)refreshControl {
//    if (!_refreshControl) {
//        _refreshControl = [[UIRefreshControl alloc]init];
//        [_refreshControl addTarget:self action:@selector(webViewReload) forControlEvents:UIControlEventValueChanged];
//    }
//    return _refreshControl;
//}
- (UIButton*)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.frame = CGRectMake(0, 0, 150, 150);
        _reloadButton.center = self.view.center;
        _reloadButton.layer.cornerRadius = 75.0;
        [_reloadButton setBackgroundImage:[UIImage imageNamed:@"sure_placeholder_error"] forState:UIControlStateNormal];
        [_reloadButton setTitle:@"您的网络有问题，请检查您的网络设置" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_reloadButton setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        _reloadButton.titleLabel.numberOfLines = 0;
        _reloadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGRect rect = _reloadButton.frame;
        rect.origin.y -= 100;
        _reloadButton.frame = rect;
        _reloadButton.enabled = NO;
    }
    return _reloadButton;
}

#pragma mark - 导航按钮
- (void)createNaviItem {
    [self showLeftBarButtonItem];
    [self showRightBarButtonItem];
}

- (void)showLeftBarButtonItem {
    if ([_webView canGoBack] || [_wk_WebView canGoBack]) {
        self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem,self.closeBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    }
}

- (void)showRightBarButtonItem {
    
}

- (UIBarButtonItem*)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem*)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    }
    return _closeBarButtonItem;
}

- (void)back:(UIBarButtonItem*)item {
    if ([_webView canGoBack] || [_wk_WebView canGoBack]) {
        [_webView goBack];
        [_wk_WebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)close:(UIBarButtonItem*)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 自定义导航按钮支持侧滑手势处理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self.delegate;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark - WebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    webView.hidden = NO;
    // 不加载空白网址
    if ([request.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //导航栏配置
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    [self showLeftBarButtonItem];
//    [_refreshControl endRefreshing];
    [webView.scrollView.mj_header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    webView.hidden = YES;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSString *urlString = [navigationAction.request.URL absoluteString];
//    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"---decidePolicyForNavigationAction--urlString = %@",urlString);
//    
//    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 加载状态回调
//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    webView.hidden = NO;
    _loadingProgressView.hidden = NO;
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //导航栏配置
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.navigationItem.title = title;
    }];
    
//    [self showLeftBarButtonItem];
    
//    [_refreshControl endRefreshing];
    [webView.scrollView.mj_header endRefreshing];
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self webViewLoadCache];
}

//HTTPS认证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
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
