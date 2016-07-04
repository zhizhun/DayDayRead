//
//  BookHeaderModelCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BookHeaderModelCell.h"
#import "URL.h"
#import <UIImageView+WebCache.h>
@implementation BookHeaderModelCell


-(void)setHeader:(BookHeaderModel *)header {
    
    NSString *avatar = [header.author objectForKey:@"avatar"];
    NSString *url = [NSString stringWithFormat:@"%@%@", B00K_ROOT, avatar];
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    NSString *nickname = [header.author objectForKey:@"nickname"];
    NSString *lv = [header.author objectForKey:@"lv"];
    self.authorLabel.text = [NSString stringWithFormat:@"%@  lv.%@", nickname, lv];
    self.titleLabel.text = header.title;
    self.contentLabel.text = header.desc;
    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"book"]];
    self.twoAuthorLabel.text = [NSString stringWithFormat:@"创建自 %@", nickname];
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
