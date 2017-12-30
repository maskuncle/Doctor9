//
//  UILabel+Utils.m
//  
//
//  Created by wangdong on 16/1/30.
//
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

-(CGFloat)autoHeight
{
    CGRect frame = self.frame;
    CGSize expectedSize;
    expectedSize = [self.text boundingRectWithSize:CGSizeMake(frame.size.width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil].size;
    frame.size.height = expectedSize.height;
    [self setFrame:frame];
    return frame.size.height;
}

-(void)fixFrame {
    CGRect frame = self.frame;
    CGFloat wid = (SCREEN_WID-8);//\\frame.size.width <= 0?(SCREEN_WID-8):frame.size.width;
    CGSize expectedSize = [self.text boundingRectWithSize:CGSizeMake(wid, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil].size;
    frame.size.height = expectedSize.height;
    frame.size.width = expectedSize.width;//frame.size.width <= 0?expectedSize.width:frame.size.width;
    [self setFrame:frame];
}

-(CGSize)getFitSize {
    CGSize expectedSize = [self.text boundingRectWithSize:CGSizeMake(SCREEN_WID-8, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil].size;
    return expectedSize;
}

-(void)fixTextShowFor2Line {
    CGSize expectedSize = [self.text boundingRectWithSize:CGSizeMake(3000.0, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil].size;
    if (expectedSize.width < self.frame.size.width) {
        self.text = [[NSString alloc]initWithFormat:@"%@\n", self.text];
    }
}

-(NSMutableAttributedString*)hightLightWithKey:(NSString*)key {
//    self.text = @"王文明或多或少文明是对方绝对";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSString *str = self.text;
    NSUInteger toatlLocation = 0;
    NSUInteger location = [str rangeOfString:key].location;
    if (location == NSNotFound) {
        return nil;
    }
    toatlLocation = location;
    while (location != NSNotFound) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(toatlLocation, [key length])];
        str = [str substringFromIndex:(location+[key length])];
        location = [str rangeOfString:key].location;
        toatlLocation += location+[key length];
    }
    return attrStr;
}

@end
