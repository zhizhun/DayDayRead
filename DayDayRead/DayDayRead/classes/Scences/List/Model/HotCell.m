//
//  HotCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "HotCell.h"
#import <UIImageView+WebCache.h>
@implementation HotCell

- (void)setHot:(Hot *)hot {
    
    if (hot != _hot) {
        _hot = nil;
        _hot = hot;
        self.titleLabel.text = _hot.title;
        if (_hot.cat == nil) {
            self.TwoLabel.text = [_hot.author stringByAppendingString:@" | 未知"];
        } else {
            
            NSArray *array = @[hot.author, hot.cat];
            NSString *str1 = [array componentsJoinedByString:@" | "];
            self.TwoLabel.text = str1;
        }
        
        if (_hot.retentionRatio == nil) {
            
            NSString *strNum = [NSString stringWithFormat:@"%@", _hot.latelyFollower];
            NSArray *array2 = @[strNum, @"暂无数据"];
            NSString *str2 = [array2 componentsJoinedByString:@" | "];
            self.lastLabel.text = str2;
        } else if(_hot.latelyFollower == nil) {
            NSString *strNum1 = [_hot.retentionRatio stringByAppendingString:@"%读者留存"];
            NSArray *array2 = @[@"暂无数据", strNum1];
            NSString *str2 = [array2 componentsJoinedByString:@" | "];
            self.lastLabel.text = str2;
        } else {
            NSString *strNum1 = [_hot.retentionRatio stringByAppendingString:@"%读者留存"];
            NSString *strNum = [[NSString stringWithFormat:@"%@", _hot.latelyFollower] stringByAppendingString:@"人在追"];
            NSArray *array2 = @[strNum, strNum1];
            NSString *str2 = [array2 componentsJoinedByString:@" | "];
            self.lastLabel.text = str2;
        }
        
        
        self.shortIntroLabel.text = _hot.shortIntro;
        
        NSString *str3 = [_hot.cover substringFromIndex:7];
        [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:str3]];
        
    }
}












- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
