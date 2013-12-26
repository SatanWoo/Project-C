//
//  UIView+Frame.m
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)resetOriginY:(float)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
