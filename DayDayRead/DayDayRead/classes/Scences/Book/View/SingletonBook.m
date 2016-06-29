//
//  SingletonBook.m
//  TTZS
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "SingletonBook.h"

static SingletonBook *book = nil;
@implementation SingletonBook

+ (instancetype)shareHandle {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        book = [[SingletonBook alloc] init];
        book.str = [NSString string];
    });
    return book;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.str = [NSString string];
//    }
//    return self;
//}
@end
