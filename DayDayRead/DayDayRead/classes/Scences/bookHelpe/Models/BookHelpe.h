//
//  BookHelpe.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/29.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookHelpe : NSObject

@property (nonatomic,copy)NSString *_id;
@property (nonatomic,strong)NSDictionary *author;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSNumber *likeCount;
@property (nonatomic,copy)NSString *state;
@property (nonatomic,copy)NSString *updated;
@property (nonatomic,copy)NSString *created;
@property (nonatomic,strong)NSNumber *commentCount;

@end
