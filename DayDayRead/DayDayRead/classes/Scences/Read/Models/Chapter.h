//
//  Chapter.h
//  DayDayRead
//
//  Created by 王志准 on 16/7/4.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chapter : NSObject
//章节名称
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *cmd;
//来源链接
@property (nonatomic,copy)NSString *url;

@end
