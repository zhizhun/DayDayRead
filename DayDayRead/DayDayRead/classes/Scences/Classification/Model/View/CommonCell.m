//
//  CommonCell.m
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "CommonCell.h"
#import <UIImageView+WebCache.h>

@implementation CommonCell

- (void)setCommonModel:(CommonModel *)commonModel {
    if (commonModel!= _commonModel) {
        _commonModel = nil;
        _commonModel = commonModel;
        self.titleLabel.text = _commonModel.title;
        self.authorLabel.text = [NSString stringWithFormat:@"%@%@", _commonModel.author,@"  | "];
       ;
        
        
        self.majorCateLabel.text = _commonModel.majorCate;
        self.shortIntroLabel.text = _commonModel.shortIntro;

      
        NSInteger stri =_commonModel.latelyFollower;
        self.latelyFollowerLabel.text = [NSString stringWithFormat:@"%ld%@",(long)stri,@" 人在追   |"];
       

        
        self.retentionRatioLabel.text = [NSString stringWithFormat:@"%@%@%@",_commonModel.retentionRatio,@"%",@" 读者留存"];

       

        NSString *str = _commonModel.cover;
        NSRange range = [str rangeOfString: @"cover"];
        if (range.location != NSNotFound) {
            NSString *addressStr = @"http://statics.zhuishushenqi.com";
            
            NSString *str1 = [NSString stringWithFormat:@"%@%@",addressStr,_commonModel.cover];
            [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:str1]];

        }else  if (range.location == NSNotFound){
            NSString *str1 = [ _commonModel.cover substringFromIndex:7];
  [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:str1]];
            
        }else        {
            
        self.bookImageView.image = [UIImage imageNamed:@"1.jpg"];
        }
    }
    
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
