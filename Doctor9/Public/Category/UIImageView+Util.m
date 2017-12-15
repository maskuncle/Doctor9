//
//  UIImageView+Util.m
//  MoxaAdvisor
//
//  Created by wangdong on 15/3/22.
//  Copyright (c) 2015年 jiudaifu. All rights reserved.
//

#import "UIImageView+Util.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageView (Util)

- (void)makeRound {
    self.layer.masksToBounds = YES; //设置为yes，就可以使用圆角
    CGFloat roundPx = MIN(self.frame.size.width/2, self.frame.size.height/2);
    [self makeRoundCorner:roundPx];
}

- (void)makeRoundCorner:(CGFloat)roundPx {
    self.layer.masksToBounds = YES; //设置为yes，就可以使用圆角
    self.layer.cornerRadius = roundPx; //设置它的圆角大小
    
//    self.layer.borderWidth = 5;   //边框宽度
//    self.layer.borderColor = [UIColor yellowColor].CGColor;   //边框颜色
}

- (UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage*)makeImageWithColor:(UIColor*)color {
    return [self createImageWithColor:color];
}

- (UIImage *)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//UIImage转UIColor
//[UIColor colorWithPatternImage:[UIImageimageNamed:@“bg.png"]]

@end
