//
//  Comic.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comic : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *Description;
@property (nonatomic,strong)NSNumber *clickrate;
@property (nonatomic,copy)NSString *coverurl;

@end
