//
//  ArcView.h
//  Doctor9
//
//  Created by heguanjie on 17/10/16.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArcView : UIView
@property(nonatomic, assign) CGFloat progress;

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth;

@end
