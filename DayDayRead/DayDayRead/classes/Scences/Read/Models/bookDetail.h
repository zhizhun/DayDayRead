//
//  bookDetail.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bookDetail : NSObject

@property (nonatomic,copy)NSString *_id;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *cover;
@property (nonatomic,copy)NSString *longIntro;
@property (nonatomic,copy)NSString *title;
//分类
@property (nonatomic,copy)NSString *minorCate;
@property (nonatomic,copy)NSString *cat;
@property (nonatomic,copy)NSString *majorCate;
//是否连载
@property (nonatomic,assign)BOOL isSerial;
//追书人数
@property (nonatomic,strong)NSNumber *latelyFollower;
//留存率
@property (nonatomic,copy)NSString *retentionRatio;
//日更新字数
@property (nonatomic,strong)NSNumber *serializeWordCount;
//标签
@property (nonatomic,strong)NSArray *tags;
//总字数
@property (nonatomic,strong)NSNumber *wordCount;
//最新更新时间
@property (nonatomic,copy)NSString *updated;

@end
