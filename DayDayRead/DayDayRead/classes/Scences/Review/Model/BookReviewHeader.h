//
//  BookReviewHeader.h
//  TTZS
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookReviewHeader : NSObject



@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSDictionary *book;
@property (nonatomic, strong) NSDictionary *author;
@property (nonatomic, strong) NSDictionary *helpful;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, copy) NSString *Id;


@end
