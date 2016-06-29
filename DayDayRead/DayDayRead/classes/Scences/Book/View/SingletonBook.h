//
//  SingletonBook.h
//  TTZS
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonBook : NSObject

@property (nonatomic, copy) NSString *str;
+ (instancetype)shareHandle;
@end
