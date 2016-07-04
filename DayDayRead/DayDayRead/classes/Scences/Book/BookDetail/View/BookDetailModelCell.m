//
//  BookDetailModelCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BookDetailModelCell.h"
#import <UIImageView+WebCache.h>
@implementation BookDetailModelCell

- (void)setDetail:(BookDetailModel *)detail {
    
    NSString *url = [detail.cover substringFromIndex:7];
   [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:url]]; 
    self.titleLabel.text = detail.title;
    
    self.authorLabel.text = [NSString stringWithFormat:@"%@|%@|暂无数据", detail.author, detail.cat];
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
