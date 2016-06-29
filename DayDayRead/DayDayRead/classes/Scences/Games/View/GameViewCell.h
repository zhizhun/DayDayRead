//
//  GameViewCell.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Game;

typedef void(^Block)();

@interface GameViewCell : UITableViewCell

@property (nonatomic,strong)Game *game;
@property (nonatomic,copy)Block block;

@end
