//
//  SingletonList.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "SingletonList.h"


static SingletonList *list = nil;
@implementation SingletonList


+ (instancetype)shareHandle {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        list = [[SingletonList alloc] init];
        list.array = [NSArray array];
    });
    return list;
}


@end
