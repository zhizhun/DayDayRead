//
//  SetCell.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "SetCell.h"
#import <Masonry.h>
#import "JXLDayAndNightMode.h"

#define kSpace 10
@interface SetCell ()



@end
@implementation SetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self jxl_setDayMode:^(UIView *view) {
            SetCell *cell = (SetCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.leftLabel.backgroundColor = [UIColor whiteColor];
            cell.leftLabel.textColor = [UIColor blackColor];
            cell.rightLabel.backgroundColor = [UIColor whiteColor];
            cell.rightLabel.textColor = [UIColor blackColor];

        } nightMode:^(UIView *view) {
            SetCell *cell = (SetCell *)view;
            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor blackColor];
            cell.leftLabel.backgroundColor = [UIColor blackColor];
            cell.leftLabel.textColor = [UIColor whiteColor];
            cell.rightLabel.backgroundColor = [UIColor blackColor];
            cell.rightLabel.textColor = [UIColor whiteColor];
        }];

        
    }
    return self;
}

- (void)initView{
    
    
    
    //要显示的内容
    self.leftLabel = [[UILabel alloc] init];
    
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    _leftLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_leftLabel];
   
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-100);
        make.height.mas_equalTo(30);
        
        
    }];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.rightLabel];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-50);
        
        make.height.mas_equalTo(30);
        
    }];

    
}
@end
