//
//  ComprehensiveDetailCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ComprehensiveDetailCell.h"
#import "ComprehensiveDetail.h"
#import  <UIImageView+WebCache.h>

@interface ComprehensiveDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *nicknameImageView;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyToLabel;
@property (nonatomic, assign)int temp;

@end
@implementation ComprehensiveDetailCell

- (void)setComprehensiveDetail:(ComprehensiveDetail*)comprehensiveDetail {
    NSString *str = [comprehensiveDetail.author objectForKey:@"avatar"];
    NSString *avatar = [NSString stringWithFormat:@"%@%@",@"http://api.zhuishushenqi.com",str];
    [self.nicknameImageView sd_setImageWithURL:[NSURL URLWithString:avatar]];
    self.floorLabel.text = [NSString stringWithFormat:@"%@楼",comprehensiveDetail.floor];
    self.nicknameLabel.text = [comprehensiveDetail.author objectForKey:@"nickname"];
    self.contentLabel.text = comprehensiveDetail.content;
    NSString *timeStr = [comprehensiveDetail.created stringByReplacingOccurrencesOfString:@"T" withString:@" "];
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
    
    if (comprehensiveDetail.replyTo.count!=0) {
        NSDictionary *author= [comprehensiveDetail.replyTo objectForKey:@"author"];
        NSString *nickname = [author objectForKey:@"nickname"];
        NSString *floor = [comprehensiveDetail.replyTo objectForKey:@"floor"];
        
        NSString *replyTo = [NSString stringWithFormat:@"%@%@(%@%@）",@"回复",nickname,floor,@"楼"];
        self.replyToLabel.text = replyTo;
    }else {
        self.replyToLabel.text = @"";
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
