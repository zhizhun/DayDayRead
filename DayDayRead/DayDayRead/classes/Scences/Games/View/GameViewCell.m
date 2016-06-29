//
//  GameViewCell.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "GameViewCell.h"
#import "Game.h"
#import <UIImageView+WebCache.h>

@interface GameViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortLabel;
@property (weak, nonatomic) IBOutlet UILabel *playLabel;


@end


@implementation GameViewCell


- (void)setGame:(Game *)game{
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:game.icon]];
    self.nameLabel.text = game.name;
    self.shortLabel.text = game.shortIntro;
    self.playLabel.text = [NSString stringWithFormat:@"有%@个小伙伴在玩",game.followers];
}

- (IBAction)disConnect:(id)sender {
    self.block();
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
