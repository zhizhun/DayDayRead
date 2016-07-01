//
//  ReViewHeaderCell.m
//  TTZS
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "ReViewHeaderCell.h"
#import <UIImageView+WebCache.h>
#import "URL.h"
@implementation ReViewHeaderCell

- (void)setHeader:(BookReviewHeader *)header {
    
    NSString *avator = [header.author objectForKey:@"avatar"];
    NSString *url1 = [NSString stringWithFormat:@"%@%@", B00K_ROOT, avator];
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:url1]];
    NSString *nickname = [header.author objectForKey:@"nickname"];
    NSString *lv = [header.author objectForKey:@"lv"];
    self.oneAutor.text = [NSString stringWithFormat:@"%@lv.%@", nickname, lv];
    self.titleLabel.text = header.title;
    self.contentLabel.text = header.content;
    NSString *title = [header.book objectForKey:@"title"];
    self.twoTltle.text = title;
    self.twoAuthou.text = [NSString stringWithFormat:@"楼主打分:%@", header.rating];
    NSString *cover = [header.book objectForKey:@"cover"];
    NSString *url = [cover substringFromIndex:7];
    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:url]];
   
   
   
    

    
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
