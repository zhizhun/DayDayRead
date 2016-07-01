//
//  DynamicHotCell.m
//  项目
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicHotCell.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "DynamicHot.h"

#define kSpace 10
#define kWith [UIScreen mainScreen].bounds.size.width - self.avatarImageView.frame.size.width-kSpace*3
@interface DynamicHotCell ()
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

static int temp = 0;
@implementation DynamicHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView {
    __weak typeof(DynamicHotCell)*cell = self;
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
        make.width.mas_equalTo (50);
        make.height.mas_equalTo (50);
    }];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor brownColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(kSpace);
        make.left.equalTo (self.avatarImageView.mas_right).offset (kSpace);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo (15);
        
    }];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
  
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset (kSpace);
        make.left.equalTo(self.nameLabel.mas_right).offset(20);
        make.right.equalTo (backView).offset (-kSpace);
        
        make.height.mas_equalTo (15);
    }];
    self.titleLabl = [[UILabel alloc] init];
    self.titleLabl.font = [UIFont systemFontOfSize:16];
    
    [backView addSubview:self.titleLabl];
    [self.titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kSpace);
        make.right.equalTo(backView).offset(-kSpace);
        
        make.height.mas_equalTo (20);
        
    }];
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.numberOfLines = 4;
  
    [backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabl.mas_bottom).offset(kSpace);
       
        make.right.equalTo(backView).offset(-kSpace);
        
        make.width.mas_equalTo (kWith);
        
    }];
    
    self.connentedLabel = [[UILabel alloc]init];
    self.connentedLabel.textAlignment = NSTextAlignmentCenter;

    self.connentedLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    
   self.connentedLabel.layer.borderWidth = 0.6f;
      self.connentedLabel.layer.cornerRadius =10.0;
    
    self.connentedLabel.layer.masksToBounds = YES;
     
    [backView addSubview:self.connentedLabel];
   
    [self.connentedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kSpace);
        make.left.equalTo (backView).offset (60);
        make.width.mas_equalTo (60);
        make.height.mas_equalTo (20);
    }];
    self.retweetedLabel = [[UILabel alloc]init];
    self.retweetedLabel.textAlignment = NSTextAlignmentCenter;
    self.retweetedLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    
    self.retweetedLabel.layer.borderWidth = 0.6f;
    self.retweetedLabel.layer.cornerRadius =10.0;
    
    self.connentedLabel.layer.masksToBounds = YES;

    [backView addSubview:self.retweetedLabel];
   
    [self.retweetedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kSpace);
        make.left.equalTo (self.connentedLabel.mas_right).offset (100);
        make.width.mas_equalTo (60);
        make.height.mas_equalTo (20);
    }];
    
    
}
- (void)setDynamicHot:(DynamicHot *)dynamicHot {
    NSString *imageStr = [dynamicHot.user objectForKey:@"avatar"];
    NSString *urlStr= @"http://statics.zhuishushenqi.com/";
    NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
   
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
    NSString *nickname = [dynamicHot.user objectForKey:@"nickname"];
    NSString *lv = [dynamicHot.user objectForKey:@"lv"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@%@",nickname,@" Lv.",lv];
   
    NSString *title = [dynamicHot.tweet objectForKey:@"title"];
    self.titleLabl.text = title;
    NSString *content = [dynamicHot.tweet  objectForKey:@"content"];
    self.contentLabel.text = content;
  
  
    
    NSString *str = [dynamicHot.tweet  objectForKey:@"created"];
    NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *strUrl1 = [strUrl stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
    
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:strUrl1];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    
    
    self.timeLabel.text =result;
    
    NSString *Str1 = [dynamicHot.tweet  objectForKey:@"commented"];
    self.connentedLabel .text =[NSString stringWithFormat:@"%@%@",@"✍",Str1];
    NSString *Str2 =[dynamicHot.tweet  objectForKey:@"retweeted"];

   self.retweetedLabel .text =[NSString stringWithFormat:@"%@%@",@"✎",Str2];

}

@end
