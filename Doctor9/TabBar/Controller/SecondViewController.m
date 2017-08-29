//
//  SecondViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "SecondViewController.h"
#import "UITabBarItem+BadgeColor.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem.badgeColor = [UIColor orangeColor];
    self.tabBarItem.badgeValue = @"1234";
}

#pragma mark - 设置导航
- (void)initNavigation{
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationItem.title = self.tabBarItem.title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
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
