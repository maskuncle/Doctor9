//
//  UIImageView+Util.h
//  MoxaAdvisor
//
//  Created by wangdong on 15/3/22.
//  Copyright (c) 2015年 jiudaifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)

- (void)makeRound;
- (void)makeRoundCorner:(CGFloat)roundPx;
- (UIImage*)makeImageWithColor:(UIColor*)color;
- (UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size;

@end
