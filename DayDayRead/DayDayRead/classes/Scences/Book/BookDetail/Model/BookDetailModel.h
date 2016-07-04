//
//  BookDetailModel.h
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDetailModel : NSObject

@property (nonatomic, copy) NSString* _id;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cat;
@property (nonatomic, assign) NSInteger *latelyFollower;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, assign) NSInteger *retentionRatio;
@property (nonatomic, strong) NSString *wordCount;
@property (nonatomic, strong) NSString *banned;



















@end
