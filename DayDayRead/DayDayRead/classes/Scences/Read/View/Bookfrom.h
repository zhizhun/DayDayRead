//
//  Bookfrom.h
//  DayDayRead
//
//  Created by 王志准 on 16/7/1.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>
//书籍来源
@interface Bookfrom : NSObject

@property (nonatomic,copy)NSString *_id;
@property (nonatomic,copy)NSString *lastChapter;
//来源链接
@property (nonatomic,copy)NSString *link;
@property (nonatomic,copy)NSString *source;
//来源名称
@property (nonatomic,copy)NSString *name;


@end
