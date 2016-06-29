//
//  SingleList.m
//  项目
//
//  Created by lanou3g on 16/6/26.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "SingleList.h"
static SingleList *list = nil;
@implementation SingleList


//单例
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = [[SingleList alloc] init];
        list.type = [NSString string];
        list.gender = [NSString string];
        
    });
    return list;
}

@end
