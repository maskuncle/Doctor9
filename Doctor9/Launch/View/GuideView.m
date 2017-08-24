//
//  GuideView.m
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "GuideView.h"

@interface GuideView () <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property UIView *holeView;
@property UIView *circleView;
@property UIButton *doneButton;

@end

@implementation GuideView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.image = [UIImage imageNamed:@"comm_bg"];
        [self addSubview:backgroundImageView];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.95, self.frame.size.width, 10)];
        [self.pageControl setBackgroundColor:[UIColor clearColor]];
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:self.pageControl];
        
        //设置指引图片(引导图)
        [self createView:@"guide1" loadMoreView:false viewWidth:0];
        [self createView:@"guide2" loadMoreView:true viewWidth:1];
        [self createView:@"guide3" loadMoreView:true viewWidth:2];
        [self createView:@"guide4" loadMoreView:true viewWidth:3];
        
        //Done Button
        self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*.35, self.frame.size.height*.85, self.frame.size.width*.3, 30)];
        [self.doneButton setTintColor:[UIColor whiteColor]];
        [self.doneButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
        self.doneButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        self.doneButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
        [self.doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.doneButton.layer.borderWidth =.5;
        self.doneButton.layer.cornerRadius = 15;
        //[self addSubview:self.doneButton];
        
        
        self.pageControl.numberOfPages = 4;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        
        //This is the starting point of the ScrollView
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
        //预防图片拉伸 出现背景空白的bug
        self.scrollView.backgroundColor = RGBA(141, 185, 14, 1.0f);
    }
    return self;
}

- (void)onFinishedIntroButtonPressed:(id)sender {
    [self.delegate onDoneButtonPressed];
    [self.doneButton setBackgroundColor:[UIColor greenColor]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
    if (self.pageControl.currentPage == 3) {
        [self addSubview:self.doneButton];
    }else{
        [self.doneButton removeFromSuperview];
    }
}


-(void)createView:(NSString *)imgName loadMoreView:(BOOL)binit viewWidth:(NSInteger)widMul{
    UIView *view = nil;
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    int w = [[UIScreen mainScreen]bounds].size.width;
    int h = [[UIScreen mainScreen]bounds].size.height;
    
    if(!binit){
        view = [[UIView alloc] initWithFrame:self.frame];
    }else{
        view = [[UIView alloc] initWithFrame:CGRectMake(originWidth * widMul, 0, originWidth, originHeight)];
    }
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:imgName];
    [view addSubview:imageview];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
