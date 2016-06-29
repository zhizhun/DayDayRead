//
//  Hot.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "Hot.h"
@implementation Hot


- (void)setValue:(id)value forKey:(NSString *)key {
    key = [key isEqualToString:@"id"] ? @"_id" : key;
    
    [super setValue:value forKey:key];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
