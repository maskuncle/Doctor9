//
//  AnimationViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/10/16.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.slider =[[UISlider alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height - 100, self.view.frame.size.width -100, 30)];
    [self.slider setMaximumValue:1.0];
    [self.slider setMinimumValue:0.0];
//    self.slider.value = 0.5;
    [self.view addSubview:self.slider];
    self.view.backgroundColor =[UIColor whiteColor];
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
