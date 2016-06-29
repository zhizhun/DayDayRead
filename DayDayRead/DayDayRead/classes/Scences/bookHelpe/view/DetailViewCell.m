//
//  DetailViewCell.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/29.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "DetailViewCell.h"
#import <UIImageView+WebCache.h>
#import "URL.h"
@interface DetailViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end


@implementation DetailViewCell

- (void)setDetail:(Detail *)detail{
    NSString *avatar = [detail.author objectForKey:@"avatar"];
    NSString *url = [NSString stringWithFormat:@"%@%@",B00K_ROOT,avatar];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.floorLabel.text = [NSString stringWithFormat:@"%@楼",detail.floor];
    
    NSString *ti = [detail.author objectForKey:@"nickname"];
    NSNumber *lv = [detail.author objectForKey:@"lv"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ lv.%@",ti,lv];
    
    self.conLabel.text = detail.content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
