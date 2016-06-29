//
//  CALayer+XibBorderColor.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "CALayer+XibBorderColor.h"
#import <UIKit/UIKit.h>
@implementation CALayer (XibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}

@end
