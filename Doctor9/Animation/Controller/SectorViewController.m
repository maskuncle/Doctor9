//
//  SectorViewController.m
//  Doctor9
//
//  Created by heguanjie on 17/10/16.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "SectorViewController.h"
#import "SectorView.h"

@interface SectorViewController ()
@property (nonatomic, strong) SectorView *sectorView;

@end

@implementation SectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sectorView = [[SectorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.sectorView.center = self.view.center;
    [self.view addSubview:self.sectorView];
    [self.slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
}

-(void)changeValue:(UISlider *)slider{
    self.sectorView.progress = slider.value;
    [PubFunc getNetWordType];
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
