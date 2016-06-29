//
//  Hot.h
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Hot : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *cover;// 图片
@property (nonatomic, strong) NSString *shortIntro;// 简介
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cat; // 类型
@property (nonatomic, strong) NSString *banned; //
@property (nonatomic, strong) NSString *latelyFollower; // 在追人数
@property (nonatomic, strong) NSString *retentionRatio; // 留存率




@end
