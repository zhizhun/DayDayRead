//
//  SingletonList.h
//  DayDayRead
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonList : NSObject


@property (nonatomic, copy) NSArray *array;


+ (instancetype)shareHandle;
@end
