//
//  ListDetailViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "ListDetailViewController.h"
#import "NetWorkRequestManager.h"
#import "SingletonList.h"
#import <UIImageView+WebCache.h>
@interface ListDetailViewController ()

@property (nonatomic, strong) NSString *str;





@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *eBookImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TwoLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortIntroLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书籍详情";
    SingletonList *list = [SingletonList shareHandle];
    self.str = list.array[1];
        [self requestData];
}

- (void)requestData {
    

    
    [NetWorkRequestManager requestType:GET urlString:self.str prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"ranking"][@"books"];
        for (NSDictionary *dict in array) {
            Hot *model = [[Hot alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showUIWithDetalInfo:model];
                
            });
            
        }
       
    } fail:^(NSError *error) {
        NSLog(@"数据请求失败");
    }];
    
}

- (void)showUIWithDetalInfo:(Hot *)hot {
    
    
        self.titleLabel.text = _hot.title;
        if (_hot.cat == nil) {
            self.TwoLabel.text = [_hot.author stringByAppendingString:@" | 未知"];
        } else {
            
            NSArray *array = @[_hot.author, _hot.cat];
            NSString *str1 = [array componentsJoinedByString:@" | "];
            self.TwoLabel.text = str1;
        }
        
        if (_hot.retentionRatio == nil) {
            
            NSString *strNum = [NSString stringWithFormat:@"%@", _hot.latelyFollower];
            NSArray *array2 = @[strNum, @" 暂无数据"];
            NSString *str2 = [array2 componentsJoinedByString:@" | "];
            self.lastLabel.text = str2;
        } else if(_hot.latelyFollower == nil) {
            NSString *strNum1 = [_hot.retentionRatio stringByAppendingString:@"% 读者留存"];
            NSArray *array2 = @[@" 暂无数据", strNum1];
            NSString *str2 = [array2 componentsJoinedByString:@" | "];
            self.lastLabel.text = str2;
        } else if (_hot.retentionRatio == nil && _hot.latelyFollower == nil) {
            
            NSArray *array = @[@" 暂无数据", @" 暂无数据"];
            NSString *str = [array componentsJoinedByString:@" | "];
            self.lastLabel.text = str;
            
        
        } else {
            NSString *strNum1 = [_hot.retentionRatio stringByAppendingString:@"% 读者留存"];
            NSString *strNum = [[NSString stringWithFormat:@"%@", _hot.latelyFollower] stringByAppendingString:@" 人在追"];
            NSArray *array2 = @[strNum, strNum1];
            NSString *str2 = [array2 componentsJoinedByString:@" | "];
            self.lastLabel.text = str2;
        }
        
        
        self.shortIntroLabel.text = _hot.shortIntro;
        
        NSString *str3 = [_hot.cover substringFromIndex:7];
        [_eBookImageView sd_setImageWithURL:[NSURL URLWithString:str3]];
        
    
    
    
    // 计算简介高度
    CGRect frame = _shortIntroLabel.frame;
    frame.size.height = [self calculateTextHeightWithHot:hot];
    
    _shortIntroLabel.frame = frame;
    
    //给约束赋值
    //        CGSize size = CGSizeMake(_scrollView.frame.size.width, _summaryLabel.frame.size.height + CGRectGetMaxY(_movieImageView.frame));
//    CGSize size = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_shortIntroLabel.frame));
//    self.contentViewHeight.constant = size.height;
//    NSString *str3 = [_hot.cover substringFromIndex:7];
//    [self.eBookImageView sd_setImageWithURL:[NSURL URLWithString:str3]];
//    


    
}

#pragma mark -- 计算文本高度
- (CGFloat)calculateTextHeightWithHot:(Hot *)hot
{
    CGSize size = CGSizeMake(_shortIntroLabel.frame.size.width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
    
    CGRect frame = [hot.shortIntro boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}


- (IBAction)saveAction:(id)sender {
}

- (IBAction)beginReadAction:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
