//
//  GJTabBarButton.m
//  Doctor9
//
//  Created by heguanjie on 17/8/29.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "GJTabBarButton.h"
#import "GJBadgeView.h"
#import "UITabBarItem+BadgeColor.h"
#import "GJTabBarConfig.h"

@interface GJTabBarButton()
/** remind number */
@property (weak , nonatomic) GJBadgeView * badgeView;
@end

@implementation GJTabBarButton


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[GJTabBarConfig shared].textColor forState:UIControlStateNormal];
        [self setTitleColor:[GJTabBarConfig shared].selectedTextColor forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.superview.frame.size.height;
    if (self.titleLabel.text && ![self.titleLabel.text isEqualToString:@""]) {
        self.titleLabel.frame = CGRectMake(0, height-16, width, 16);
        self.imageView.frame = CGRectMake(0 , 0, width, 35);
    }
    else{
        self.imageView.frame = CGRectMake(0 , 0, width, height);
    }
}

/**
 *  Set red dot item
 */
- (void)setItem:(UITabBarItem *)item {
    self.badgeView.badgeValue = item.badgeValue;
    self.badgeView.badgeColor = item.badgeColor;
}

/**
 *  getter
 */
- (GJBadgeView *)badgeView {
    if (!_badgeView) {
        GJBadgeView * badgeView = [[GJBadgeView alloc] init];
        _badgeView = badgeView;
        [self addSubview:badgeView];
    }
    return _badgeView;
}


- (void)setHighlighted:(BOOL)highlighted{
}

@end
