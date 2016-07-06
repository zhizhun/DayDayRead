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
static int temp =0;
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
    
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset (kSpace);
        make.left.equalTo(self.nameLabel.mas_right).offset(20);
        make.right.equalTo (backView).offset (-kSpace);
       
        make.height.mas_equalTo (15);
    }];
    self.titleLabl = [[UILabel alloc] init];
    self.titleLabl.numberOfLines = 2;
    self.titleLabl.font = [UIFont systemFontOfSize:16];
    
    
    [backView addSubview:self.titleLabl];
    [self.titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kSpace);
        make.right.equalTo(backView).offset(-kSpace);


        
    }];
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.numberOfLines = 5;
   
    [backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabl.mas_bottom).offset(kSpace);

        make.right.equalTo(backView).offset(-15);
        
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
//        make.bottom.equalTo(backView).offset(10);
        make.width.mas_equalTo (70);
        make.height.mas_equalTo (20);
    }];
    self.retweetedLabel = [[UILabel alloc]init];
    self.retweetedLabel.textAlignment = NSTextAlignmentCenter;
    self.retweetedLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    self.retweetedLabel.layer.borderWidth = 0.6f;
    self.retweetedLabel.layer.cornerRadius =10.0;
    
    self.connentedLabel.layer.masksToBounds = YES;;
    [backView addSubview:self.retweetedLabel];
    
    [self.retweetedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kSpace);
        make.left.equalTo (self.connentedLabel.mas_right).offset (100);
//         make.bottom.equalTo(backView).offset(10);
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

        NSString *title = [dynamic.refTweet objectForKey:@"title"];
        self.titleLabl.text = title;
        NSString *content = [dynamic.refTweet objectForKey:@"content"];
        self.contentLabel.text = content;

    
    NSString *str = [dynamic.refTweet  objectForKey:@"created"];
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
    
    NSString *Str1 = [dynamic.refTweet  objectForKey:@"commented"];
    self.connentedLabel .text =[NSString stringWithFormat:@"%@%@",@"✍",Str1];
    NSString *Str2 =[dynamic.refTweet  objectForKey:@"retweeted"];
    
    self.retweetedLabel .text =[NSString stringWithFormat:@"%@%@",@"✎",Str2];
    
    
    if (dynamic.from.count == 0  ) {
 
        self.timeLabel.text = @"刚刚";
        self.retweetedLabel.text = @"90";
         self.nameLabel.text = @"miss Lv.9";
        self.titleLabl.text = @"感谢一路有你，让我们携手开启新未来！";
       self.retweetedLabel .text =[NSString stringWithFormat:@"%@%s",@"✎","6"];
        self.contentLabel.text = @"注:本贴只是个人所见，如有补充，请勿过激。\n\n童年的回忆——一路成长的网络文学\n\n网络文学从最开始伴随着互联网的兴起，也是一步步发展壮大。早期，网络小说还只是一部分人的尝试，而这批先驱者所写的小说………就个人看法，这批先驱者所在的那时，网络小说是质量最高的时段。\n\n把时间往后拨五年，网吧开始大量出现，电子产品也开始大量出现，网络小说进入了一个高速发展时期。而此时，也出现问题……盗版网站的大量出现，";
         self.connentedLabel .text =[NSString stringWithFormat:@"%@%s",@"✍","8"];
        self.avatarImageView.image = [UIImage imageNamed:@"1.jpg"];
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
