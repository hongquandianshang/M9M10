//
//  UINavigationBar+Utility.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-18.
//
//

#import "UINavigationBar+Utility.h"

@implementation UINavigationBar (CustomNavigationBar)

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //    UIImage *barImage = [UIImage imageNamed:@"global_head_bg.png"];
    //    [barImage drawInRect:rect];
    UIImage *image = [UIImage imageNamed:@"titlebar.png"];
    [image drawInRect:rect];
}

@end
