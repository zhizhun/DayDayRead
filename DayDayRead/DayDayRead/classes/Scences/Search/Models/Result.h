//
//  Result.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/27.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (nonatomic,copy)NSString *_id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *cat;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *cover;
@property (nonatomic,copy)NSString *shortIntro;
@property (nonatomic,copy)NSString *lastChapter;
@property (nonatomic,strong)NSNumber *retentionRatio;
@property (nonatomic,strong)NSNumber *latelyFollower;
@property (nonatomic,strong)NSNumber *wordCount;

@end
