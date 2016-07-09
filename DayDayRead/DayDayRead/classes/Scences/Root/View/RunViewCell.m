//
//  RunViewCell.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "RunViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@implementation RunViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self jxl_setDayMode:^(UIView *view) {
            RunViewCell *cell = (RunViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            
            
        } nightMode:^(UIView *view) {
            RunViewCell *cell = (RunViewCell *)view;
            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor blackColor];
            
        }];
        
        
    }
    return self;
}



- (void)setBook:(bookDetail *)book {
    
    self.bookTitleLabel.text = book.title;
    self.authorLabel.text = book.author;
    
    NSString *cover = [book.cover substringFromIndex:7];
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:cover]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
