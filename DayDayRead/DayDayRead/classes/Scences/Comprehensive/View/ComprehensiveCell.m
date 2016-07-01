//
//  ComprehensiveCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ComprehensiveCell.h"
#import "Comprehensive.h"
#import <UIImageView+WebCache.h>


@interface ComprehensiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *nickImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;

@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (nonatomic, assign)int temp;

@end
@implementation ComprehensiveCell
- (void)setComprehensive:(Comprehensive *)comprehensive{

    NSString *urlStr = [comprehensive.author objectForKey:@"avatar"];
    
    NSString *author = [NSString stringWithFormat:@"%@%@",@"http://api.zhuishushenqi.com",urlStr];

        [self.nickImageView sd_setImageWithURL:[NSURL URLWithString:author]];
    NSString *nickname = [comprehensive.author objectForKey:@"nickname"];
    NSString  *aa = [comprehensive.author objectForKey:@"lv"];
   
    NSString *str = [nickname stringByAppendingString:@" Lv."];
    
    NSString *str1 = [NSString stringWithFormat:@"%@%@",str,aa];
    
    self.nickNameLabel.text = str1;
    
    NSString *timeStr = [comprehensive.created stringByReplacingOccurrencesOfString:@"T" withString:@" "];
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

 
    self.titleLabel.text = comprehensive.title;
    
    self.searchLabel.text = [NSString stringWithFormat:@"%@",comprehensive.commentCount];
    self.attentionLabel.text = [NSString stringWithFormat:@"%@",comprehensive.voteCount];
    
}
@end
