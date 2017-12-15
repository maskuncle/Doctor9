//
//  ArcView.m
//  Doctor9
//
//  Created by heguanjie on 17/10/16.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "ArcView.h"
#import "UIColor+MLBUtilities.h"

@interface ArcView ()
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,assign) CGFloat lineWidth;

@property(nonatomic,strong) CAShapeLayer *foreLayer;//蒙版layer

@end

@implementation ArcView
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lineWidth = lineWidth;
        
        [self seup:frame];
    }
    return self;
}
-(void)seup:(CGRect) rect{
    
    //背景灰色
    CAShapeLayer *shapeLayer =[[CAShapeLayer alloc]init];
    
    shapeLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.width);
    shapeLayer.lineWidth = _lineWidth;
    
    shapeLayer.fillColor =[UIColor clearColor].CGColor;
    shapeLayer.strokeColor = RGBA(50, 50, 50, 1).CGColor;
    
    
    CGPoint center =  CGPointMake((rect.size.width )/2, (rect.size.width)/2);
    
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width- _lineWidth)/2 startAngle:-0.5 *M_PI endAngle:1.5 *M_PI clockwise:YES];
    shapeLayer.path = bezierPath.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    
    
    //渐变色，加蒙版，显示的蒙版的区域
    //CAGradientlayer可以绘制一个充满整个图层的颜色梯度(包括原型图层等图层)在一个背景颜色上
    CAGradientLayer *gradientLayer =[[CAGradientLayer alloc]init];
    
    gradientLayer.frame = self.bounds;
    
    gradientLayer.colors = @[(id)[UIColor colorWithHexString:@"#5F98FC"].CGColor,(id)[UIColor colorWithHexString:@"#47BFFC"].CGColor];
    
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    [self.layer addSublayer:gradientLayer];
    
    
    //CAGradientLayer的遮挡CAShapeLayer(这个不需要addSublayer，只需.mask=layer)
    self.foreLayer = [CAShapeLayer layer];
    self.foreLayer.frame = self.bounds;
    
    self.foreLayer.fillColor =[UIColor clearColor].CGColor;
    
    self.foreLayer.lineWidth = self.lineWidth;
    self.foreLayer.strokeColor = [UIColor redColor].CGColor;
    
    self.foreLayer.strokeEnd = 0;
    self.foreLayer.lineCap = kCALineCapRound;   //线头的属性/即形状
    
    self.foreLayer.path = bezierPath.CGPath;
    
    gradientLayer.mask = self.foreLayer;
    
    
    // 百分比label
    self.label =[[UILabel alloc]initWithFrame:self.bounds];
    self.label.text  = @"";
    [self addSubview:self.label];
    self.label.font =[UIFont boldSystemFontOfSize:42];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor =[UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    self.label.text = [NSString stringWithFormat:@"%.f%%",progress *100];
    self.foreLayer.strokeEnd = _progress;
}

@end
