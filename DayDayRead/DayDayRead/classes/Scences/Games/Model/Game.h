//
//  Game.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
//游戏名称
@property (nonatomic,copy)NSString *name;
//游戏简介
@property (nonatomic,copy)NSString *shortIntro;
//游戏链接
@property (nonatomic,copy)NSString *iosLink;
//游戏图标
@property (nonatomic,copy)NSString *icon;
//在玩人数
@property (nonatomic,strong)NSNumber *followers;
@end
