//
//  CommonModel.h
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject
//标题
@property (nonatomic, copy)NSString *title;
//作者
@property (nonatomic, copy)NSString *author;
//类型
@property (nonatomic, copy)NSString *majorCate;
//简介
@property (nonatomic, copy)NSString *shortIntro;
//追书人数
@property (nonatomic, assign)NSInteger latelyFollower;
//读者留存
@property (nonatomic, copy)NSString *retentionRatio;
//图片
@property (nonatomic, copy)NSString *cover;
//ID
@property (nonatomic, copy)NSString *_id;

@end
