//
//  BookReviewOne.h
//  TTZS
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookReviewOne : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *book;
@property (nonatomic, strong) NSDictionary *helpful;
@property (nonatomic, strong) NSString *state;


@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSString *updated;
@property (nonatomic, strong) NSString *created;












@end
