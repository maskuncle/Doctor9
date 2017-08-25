//
//  GJTabBarController.m
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "GJTabBarController.h"

@interface GJTabBarController ()

@end

@implementation GJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *firstController = [[UIViewController alloc] init];
    // 给控制器 包装 一个导航控制器
    UINavigationController *   nav = [[UINavigationController alloc] initWithRootViewController:firstController];
    // 添加为子控制器
    [self addChildViewController:nav];
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
