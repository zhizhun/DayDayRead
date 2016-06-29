//
//  ComicViewCell.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ComicViewCell.h"
#import <UIImageView+WebCache.h>
#import "Comic.h"
@interface ComicViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *perLabel;



@end

@implementation ComicViewCell

- (void)setComic:(Comic *)comic{
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:comic.coverurl]];
    self.nameLabel.text = comic.name;
    self.introLabel.text = comic.Description;
    self.perLabel.text = [NSString stringWithFormat:@"%@人在看",comic.clickrate];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
