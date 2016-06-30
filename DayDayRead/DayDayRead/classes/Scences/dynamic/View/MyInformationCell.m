//
//  MyInformationCell.m
//  项目
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "MyInformationCell.h"
#import <Masonry.h>


@interface MyInformationCell ()


@end
@implementation MyInformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self stepLayout];
    }
    return self;
}

- (void)stepLayout {
    //添加一个背景视图
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    __weak typeof(MyInformationCell) *cell = self;
    
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //添加约束
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
    }];
    
    
    //要显示的内容
    self.contentLabel = [[UILabel alloc] init];
    
    _contentLabel.textAlignment = NSTextAlignmentLeft;
   
    [backView addSubview:_contentLabel];
   
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(0);
        make.left.equalTo(backView).offset(10);
        make.right.equalTo(backView).offset(-100);
        make.height.mas_equalTo(30);
        
        
    }];
    self.imageView1 = [[UIImageView alloc] init];
    
    [backView addSubview:self.imageView1];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(backView).offset(0);
        make.right.equalTo(backView).offset(-50);
        
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    self.contentLabel1 = [[UILabel alloc] init];
    
    [backView addSubview:self.contentLabel1];
    
    [self.contentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView).offset(0);
        make.right.equalTo(backView).offset(-50);
        
        make.height.mas_equalTo(30);
       
    }];

}

@end
