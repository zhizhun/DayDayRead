//
//  BookReViewDTCell.m
//  TTZS
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookReViewDTCell.h"
#import "URL.h"
#import <UIImageView+WebCache.h>
@implementation BookReViewDTCell

- (void)setThr:(BookReviewThr *)thr {
    
    self.contentLabel.text = thr.content;
    self.floorLabel.text = [NSString stringWithFormat:@"%@楼", thr.floor];
    NSString *autor = [thr.author objectForKey:@"nickname"];
    NSString *lv = [thr.author objectForKey:@"lv"];
    NSString *avatar = [thr.author objectForKey:@"avatar"];
    self.autorLabel.text = [NSString stringWithFormat:@"%@ lv.%@", autor, lv];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",B00K_ROOT, avatar];
    [self.deImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"book"]];
    
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
