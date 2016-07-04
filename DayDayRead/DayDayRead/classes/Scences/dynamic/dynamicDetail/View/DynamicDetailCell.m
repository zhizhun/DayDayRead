//
//  DynamicDetailCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "DynamicDetailCell.h"
#import "DynamicDetail.h"
#import <UIImageView+WebCache.h>

@interface DynamicDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *nickNameImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, assign)int temp;

@end
@implementation DynamicDetailCell


- (void)setDynamicDetail:(DynamicDetail *)dynamicDetail {
    
    NSString *imageStr = [dynamicDetail.user objectForKey:@"avatar"];
    NSString *urlStr= @"http://statics.zhuishushenqi.com";
    NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
    
    
    [self.nickNameImageView sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
    NSString *nickname = [dynamicDetail.user objectForKey:@"nickname"];
    NSString *lv = [dynamicDetail.user objectForKey:@"lv"];
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@%@%@",nickname,@" Lv.",lv];
//
//  
    self.titleLabel.text =  [dynamicDetail.tweet objectForKey:@"title"];
   
    self.contentLabel.text = [dynamicDetail.tweet objectForKey:@"content"];
    
    NSString *timeStr = [dynamicDetail.created stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *timeStr1 = [timeStr stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
    //把字符串转为NSdata
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:timeStr1];
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((_temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",_temp];
    }
    
    else if((_temp = _temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",_temp];
    }
    
    else if((_temp = _temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",_temp];
    }
    
    else if((_temp = _temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",_temp];
    }
    else{
        _temp = _temp/12;
        result = [NSString stringWithFormat:@"%d年前",_temp];
    }
    self.timeLabel.text =result;

    
    
//    if ([_dynamic.refTweet objectForKey:@"post"].count == 0  ) {
//        
//        self.timeLabel.text = @"刚刚";
//        //        self.retweetedLabel.text = @"90";
//        self.nickNameLabel.text = @"miss Lv.9";
//        self.titleLabel.text = @"感谢一路有你，让我们携手开启新未来！";
//        //        self.retweetedLabel .text =[NSString stringWithFormat:@"%@%s",@"✎","6"];
//        self.contentLabel.text = @"注:本贴只是个人所见，如有补充，请勿过激。\n\n童年的回忆——一路成长的网络文学\n\n网络文学从最开始伴随着互联网的兴起，也是一步步发展壮大。早期，网络小说还只是一部分人的尝试，而这批先驱者所写的小说………就个人看法，这批先驱者所在的那时，网络小说是质量最高的时段。\n\n把时间往后拨五年，网吧开始大量出现，电子产品也开始大量出现，网络小说进入了一个高速发展时期。而此时，也出现问题……盗版网站的大量出现，";
//        //        self.connentedLabel .text =[NSString stringWithFormat:@"%@%s",@"✍","8"];
//        self.nickNameImageView.image = [UIImage imageNamed:@"1.jpg"];
//    }

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
