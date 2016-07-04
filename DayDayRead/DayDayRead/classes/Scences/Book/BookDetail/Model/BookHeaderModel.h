//
//  BookHeaderModel.h
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookHeaderModel : NSObject


@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *updated;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *author;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *stickStopTime;
@property (nonatomic, strong) NSString *isDraft;
@property (nonatomic, strong) NSString *isDistillate;
@property (nonatomic, strong) NSString *collectorCount;
@property (nonatomic, strong) NSDictionary *books;























@end
