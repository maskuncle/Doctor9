//
//  UILabel+Utils.h
//  
//
//  Created by wangdong on 16/1/30.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

-(CGFloat)autoHeight;
-(void)fixFrame;
-(CGSize)getFitSize;
-(void)fixTextShowFor2Line;
-(NSMutableAttributedString*)hightLightWithKey:(NSString*)key;

@end
