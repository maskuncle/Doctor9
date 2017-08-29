//
//  MainViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "MainViewController.h"
#import "GJTabBarController.h"

@interface MainViewController ()<UITableViewDelegate , GJTabBarDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    [self initButtons];
    
    
    GJTABBARCONTROLLER.tabbar.delegate = self;
    self.tabBarItem.badgeValue = @"remind";
}

#pragma mark - CYTabBarDelegate
//中间按钮点击
- (void)tabbar:(GJTabBar *)tabbar clickForCenterButton:(GJCenterTabBarBtn *)centerButton{
    NSLog(@"--- 点击了中间的按钮");
//    [PlusAnimate standardPublishAnimateWithView:centerButton];
}
//是否允许切换
- (BOOL)tabBar:(GJTabBar *)tabBar willSelectIndex:(NSInteger)index{
    NSLog(@"将要切换到---> %ld",index);
    return YES;
}
//通知切换的下标
- (void)tabBar:(GJTabBar *)tabBar didSelectIndex:(NSInteger)index{
    NSLog(@"切换到---> %ld",index);
}

#pragma mark - 跳转页面
- (void)btnClick{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 隐藏tabbar
- (void)hidden{
    [GJTABBARCONTROLLER setGJTabBarHidden:!GJTABBARCONTROLLER.tabbar.hidden animated:YES];
}



#pragma mark - 设置导航
- (void)initNavigation{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = self.tabBarItem.title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 设置功能按钮
- (void)initButtons{
    CGFloat x = ([UIScreen mainScreen].bounds.size.width-150)/2;
    UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(x, 200, 150, 30)];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1  = [[UIButton alloc]initWithFrame:CGRectMake(x, 300, 150, 30)];
    [btn1 setTitle:@"隐藏或显示tabbar" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
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
