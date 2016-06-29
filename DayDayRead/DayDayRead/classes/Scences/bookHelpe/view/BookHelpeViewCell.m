//
//  BookHelpeViewCell.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/28.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BookHelpeViewCell.h"
#import <UIImageView+WebCache.h>
#import "BookHelpe.h"
#import "URL.h"
@interface BookHelpeViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sousuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *guanzhuLabel;


@end


@implementation BookHelpeViewCell

- (void)setBookHelpe:(BookHelpe *)bookHelpe{
    NSString *avatar = [bookHelpe.author objectForKey:@"avatar"];
    NSString *url = [NSString stringWithFormat:@"%@%@",B00K_ROOT,avatar];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    NSString *ti = [bookHelpe.author objectForKey:@"nickname"];
    NSNumber *lv = [bookHelpe.author objectForKey:@"lv"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ lv.%@",ti,lv];
    
    self.titleLabel.text = bookHelpe.title;
    self.sousuoLabel.text = [NSString stringWithFormat:@"%@",bookHelpe.likeCount];
    self.guanzhuLabel.text = [NSString stringWithFormat:@"%@",bookHelpe.commentCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
