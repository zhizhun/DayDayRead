//
//  Detail.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/29.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail : NSObject

@property (nonatomic,copy)NSString *_id;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,strong)NSDictionary *author;
@property (nonatomic,strong)NSNumber *floor;

@end
