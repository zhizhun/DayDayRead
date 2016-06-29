//
//  DynamicCell.m
//  项目
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

#define kSpace 10
#define kWith [UIScreen mainScreen].bounds.size.width - self.avatarImageView.frame.size.width-kSpace*3
@interface DynamicCell ()
//头像
@property (nonatomic,strong)UIImageView *avatarImageView;
//名称
@property (nonatomic, strong)UILabel *nameLabel;
//时间
@property (nonatomic, strong)UILabel *timeLabel;
//标题
@property (nonatomic, strong)UILabel *titleLabl;
//内容
@property (nonatomic, strong)UILabel *contentLabel;
//评论人数
@property (nonatomic, strong)UILabel *connentedLabel;
//转发人数
@property (nonatomic, strong)UILabel *retweetedLabel;

@end

@implementation DynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView {
        __weak typeof(DynamicCell)*cell = self;
    UIView *backView = [[UIView alloc] init];;
   
    [self.contentView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
        
    }];
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.image = [UIImage imageNamed:@"12.jpg"];
   
    [backView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (backView).offset(kSpace);
        make.left.equalTo (backView).offset(kSpace);
        make.width.mas_equalTo (50);
        make.height.mas_equalTo (50);
    }];
    self.nameLabel = [[UILabel alloc] init];
   
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(kSpace);
        make.left.equalTo (self.avatarImageView.mas_right).offset (kSpace);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo (15);
        
    }];
    self.timeLabel = [[UILabel alloc] init];
    
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset (kSpace);
        make.left.equalTo(self.nameLabel.mas_right).offset(50);
        make.right.equalTo (backView).offset (-kSpace);
       
        make.height.mas_equalTo (15);
    }];
    self.titleLabl = [[UILabel alloc] init];
    self.titleLabl.font = [UIFont systemFontOfSize:15];
    
    
    [backView addSubview:self.titleLabl];
    [self.titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kSpace);
        make.right.equalTo(backView).offset(-kSpace);

         make.height.mas_equalTo (20);
        
    }];
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.contentLabel.numberOfLines = 4;
   
    [backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabl.mas_bottom).offset(kSpace);

        make.right.equalTo(backView).offset(-kSpace);
        
        make.width.mas_equalTo (kWith);
        
    }];
    
    self.connentedLabel = [[UILabel alloc]init];
    self.connentedLabel.backgroundColor = [UIColor brownColor];
  
    [backView addSubview:self.connentedLabel];
   ;
    [self.connentedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kSpace);
        make.left.equalTo (backView).offset (60);
        make.width.mas_equalTo (60);
        make.height.mas_equalTo (20);
    }];
    self.retweetedLabel = [[UILabel alloc]init];
    self.retweetedLabel.backgroundColor = [UIColor brownColor];
    [backView addSubview:self.retweetedLabel];
    
    [self.retweetedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kSpace);
        make.left.equalTo (self.connentedLabel.mas_right).offset (100);
        make.width.mas_equalTo (60);
        make.height.mas_equalTo (20);
    }];

    
}
- (void)setDynamic:(Dynamic *)dynamic {

        
        NSString *imageStr = [dynamic.from objectForKey:@"avatar"];
        NSString *urlStr= @"http://statics.zhuishushenqi.com/";
        NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
      
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
        NSString *nickname = [dynamic.from objectForKey:@"nickname"];
        NSString *lv = [dynamic.from objectForKey:@"lv"];
        self.nameLabel.text = [NSString stringWithFormat:@"%@%@%@",nickname,@" Lv.",lv];
//        NSDictionary *tweet = [NSDictionary dictionary];
        NSString *title = [dynamic.refTweet objectForKey:@"title"];
        self.titleLabl.text = title;
        NSString *content = [dynamic.refTweet objectForKey:@"content"];
        self.contentLabel.text = content;
//
    NSString *timeStr = [dynamic.refTweet  objectForKey:@"created"];
    
    
    NSString *timeStr1 = [timeStr substringToIndex:10];
    self.timeLabel.text =timeStr1;
    
    NSString *Str1 = [dynamic.refTweet  objectForKey:@"commented"];
    self.connentedLabel .text =[NSString stringWithFormat:@"%@%@",@"✍",Str1];
    NSString *Str2 =[dynamic.refTweet  objectForKey:@"retweeted"];
    
    self.retweetedLabel .text =[NSString stringWithFormat:@"%@%@",@"✎",Str2];
    
        
    //}
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
