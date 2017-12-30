//
//  ArcViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/10/16.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "ArcViewController.h"
#import "ArcView.h"

@interface ArcViewController ()
@property (nonatomic, strong) ArcView *arcView;

@end

@implementation ArcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arcView = [[ArcView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 30, self.view.frame.size.width - 30) lineWidth:30];
    self.arcView.center = self.view.center;
    [self.view addSubview:self.arcView];
    [self.slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
}

-(void)sliderMethod:(UISlider*)slider{
    self.arcView.progress = slider.value;
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
