//
//  DynamicMineCell.m
//  项目
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicMineCell.h"
#import <Masonry.h>
#define kSpace 10

@interface DynamicMineCell ()
//头像
@property (nonatomic,strong)UIImageView *avatarImageView;
//名称
@property (nonatomic, strong)UILabel *nameLabel;
//关注数量
@property (nonatomic, strong)UILabel *attentionNumLabel;
//关注
@property (nonatomic, strong)UILabel *attentionLabel;
//粉丝数量
@property (nonatomic, strong)UILabel *fansNumLabel;
//粉丝
@property (nonatomic, strong)UILabel *fansLabel;
//编辑按钮
@property (nonatomic,strong)UIButton *button;

@end
@implementation DynamicMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    ;
    __weak typeof(DynamicMineCell *)cell = self;
    UIView *backView = [[UIView alloc] init];;
   
    [self.contentView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
        
    }];
    self.avatarImageView = [[UIImageView alloc] init];
    
    [backView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (backView).offset(kSpace);
        make.left.equalTo (backView).offset(kSpace);
        make.width.mas_equalTo (40);
        make.height.mas_equalTo (40);
    }];
    self.nameLabel = [[UILabel alloc] init];
  
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(kSpace);
        make.left.equalTo (self.avatarImageView.mas_right).offset (kSpace);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo (15);
        
    }];
    self.attentionNumLabel = [[UILabel alloc] init];
    self.attentionNumLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:self.attentionNumLabel];
    [self.attentionNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left).offset(kSpace);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        
    }];
    self.fansNumLabel = [[UILabel alloc] init];
    self.fansNumLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:self.fansNumLabel];
    [self.attentionNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionNumLabel.mas_left).offset(kSpace*3);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        
    }];
    self.attentionLabel = [[UILabel alloc] init];
    self.attentionLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:self.attentionLabel];
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left).offset(kSpace);
        make.top.equalTo(self.attentionNumLabel.mas_bottom).offset(kSpace/2);
        make.width.mas_equalTo(kSpace*2);
        make.height.mas_equalTo(kSpace*2);
        
    }];
    self.fansLabel = [[UILabel alloc] init];
    self.fansLabel.textAlignment = NSTextAlignmentCenter;
    
    [backView addSubview:self.fansLabel];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionLabel.mas_left).offset(kSpace+20);
        make.top.equalTo(self.fansNumLabel.mas_bottom).offset(kSpace/2);
        make.width.mas_equalTo(kSpace*2);
        make.height.mas_equalTo(kSpace*2);
        
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor redColor];
    [self.button setTitle:@"编辑" forState:UIControlStateNormal];
        
    
}


@end
