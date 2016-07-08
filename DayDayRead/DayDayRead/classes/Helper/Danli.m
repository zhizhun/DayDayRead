//
//  Danli.m
//  DayDayRead
//
//  Created by 王志准 on 16/7/7.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "Danli.h"

static Danli *danli = nil;
@implementation Danli

+ (instancetype)shareDanli{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        danli = [[Danli alloc] init];
        //属性的初始化
        danli.num = 1;
    });
    return danli;
}

@end
