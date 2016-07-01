//
//  BookReViewCell.m
//  TTZS
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookReViewCell.h"
#import <UIImageView+WebCache.h>
#import "BookReviewOne.h"
@implementation BookReViewCell

-(void)setBookReviewOne:(BookReviewOne *)bookReviewOne {
    
   self.twoTitleLabel.text = bookReviewOne.title;
    NSString *title = [bookReviewOne.book objectForKey:@"title"];
    NSString *cover = [bookReviewOne.book objectForKey:@"cover"];
    NSString *cover1 = [cover substringFromIndex:7];
    NSString *type = [bookReviewOne.book objectForKey:@"type"];
    NSString *no = [bookReviewOne.helpful objectForKey:@"no"];
    NSString *yes = [bookReviewOne.helpful objectForKey:@"yes"];
    NSString *str1 = [NSString stringWithFormat:@"[%@]",type];
    NSArray *arr1 = @[title, str1];
    self.oneTitleLabel.text = [arr1 componentsJoinedByString:@""];
    NSString *str2 = [NSString stringWithFormat:@"%@", no];
    NSString *str3 = [NSString stringWithFormat:@"%@有用", yes];
    self.lastLabel.text = [@[str2, str3] componentsJoinedByString:@"/"];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:cover1] placeholderImage:[UIImage imageNamed:@"book"]];
    
    
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
