//
//  ResultsViewCell.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/27.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ResultsViewCell.h"
#import <UIImageView+WebCache.h>
#import "Result.h"
@interface ResultsViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *runLabel;

@end

@implementation ResultsViewCell

- (void)setResult:(Result *)result{
    if (![result.cover isEqualToString:@""]) {
        NSString *str = [result.cover substringFromIndex:7];
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    }else{
        self.myImageView.image = [UIImage imageNamed:@"Icon-Small-40@2x副本"];
    }
    if (!self.myImageView.image) {
        self.myImageView.image = [UIImage imageNamed:@"Icon-Small-40@2x副本"];
    }
    self.nameLabel.text = result.title;
    if ([result.retentionRatio isKindOfClass:[NSValue class]]) {
        self.runLabel.text = [NSString stringWithFormat:@"%@人在追 | %@%%读者留存率 | %@著",result.latelyFollower,result.retentionRatio,result.author];
    }else{
        self.runLabel.text = [NSString stringWithFormat:@"%@人在追 | 0%%读者留存率 | %@著",result.latelyFollower,result.author];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
