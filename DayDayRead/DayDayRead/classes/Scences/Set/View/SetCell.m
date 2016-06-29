//
//  SetCell.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "SetCell.h"
#import <Masonry.h>

#define kSpace 10
@interface SetCell ()



@end
@implementation SetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        
    }
    return self;
}

- (void)initView{
    //添加一个背景视图
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    //    backView.backgroundColor = DB_RANDOM_COLOR;
    __weak typeof(SetCell) *cell = self;
    //将
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //添加约束
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
    }];
    
    
    //要显示的内容
    self.leftLabel = [[UILabel alloc] init];
    
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    _leftLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:_leftLabel];
   
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(0);
        make.left.equalTo(backView).offset(10);
        make.right.equalTo(backView).offset(-100);
        make.height.mas_equalTo(30);
        
        
    }];
//    self.switchView = [[UISwitch alloc] init];
//    
//    [backView addSubview:self.switchView];
//    
//    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(backView).offset(0);
//        make.right.equalTo(backView).offset(-50);
//        
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(30);
//    }];
    self.rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:self.rightLabel];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView).offset(0);
        make.right.equalTo(backView).offset(-50);
        
        make.height.mas_equalTo(30);
        
    }];

    
}
@end
