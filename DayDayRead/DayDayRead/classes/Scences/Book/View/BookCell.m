//
//  BookCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookCell.h"
#import <UIImageView+WebCache.h>
@implementation BookCell


- (void)setBook:(Book *)book {
    
    if (book != _book) {
        _book = nil;
        _book = book;
        self.titleLabel.text = _book.title;
        self.authorLabel.text = _book.author;
        
        if (_book.collectorCount == nil) {
            
            NSString *strNum = [NSString stringWithFormat:@"共 %@ 本书", _book.bookCount];
            NSArray *array = @[strNum, @"暂无数据"];
            NSString *str = [array componentsJoinedByString:@" | "];
            self.lastLabel.text = str;
        } else if(_book.bookCount == nil) {
            NSString *strNum = [NSString stringWithFormat:@"%@ 人收藏", _book.collectorCount];
            NSArray *array = @[@"暂无数据", strNum];
            NSString *str = [array componentsJoinedByString:@" | "];
            self.lastLabel.text = str;
        } else {
            NSString *strNum = [NSString stringWithFormat:@"共 %@ 本书", _book.bookCount];
            NSString *strNum1 = [NSString stringWithFormat:@"%@ 人在追", _book.collectorCount];
            NSArray *array = @[strNum, strNum1];
            NSString *str = [array componentsJoinedByString:@" | "];
            self.lastLabel.text = str;
        }
        
        self.descLabel.text = _book.desc;
        
        NSString *str = [_book.cover substringFromIndex:7];
        [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"book"]];
        
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
