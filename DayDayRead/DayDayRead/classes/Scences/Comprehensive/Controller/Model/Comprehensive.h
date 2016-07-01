//
//  Comprehensive.h
//  DayDayRead
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comprehensive : NSObject
@property (nonatomic,copy)NSString *_id;
//标题
@property (nonatomic, copy)NSString *title;
@property (nonatomic,copy)NSDictionary *author;
@property (nonatomic,copy)NSString *updated;
@property (nonatomic,copy)NSString *created;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *voteCount;
@end
