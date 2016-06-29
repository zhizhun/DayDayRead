//
//  OneDetailViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "OneDetailViewController.h"
#import "ListDetailViewController.h"
#import "NetWorkRequestManager.h"
#import "SingletonList.h"
#import <UIImageView+WebCache.h>
#import "OneViewController.h"
@interface OneDetailViewController ()
@property (nonatomic, strong) NSString *str;


@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *eBookImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TwoLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortIntroLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (nonatomic, strong) UIViewController *viewController;



@end

@implementation OneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SingletonList *list = [SingletonList shareHandle];
    self.str = list.array[0];
    
    [self requestData];
    
    self.button.layer.borderColor = [[UIColor redColor] CGColor];
    self.button.layer.cornerRadius = 2;
    
    
    self.title = @"书籍详情";
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    
}

//- (void)backAction:(UIBarButtonItem *)sender {
//    
//    
//    [self dismissViewControllerAnimated:NO completion:nil];
//}



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
    
    if (hot.retentionRatio == nil) {
        
        NSString *strNum = [NSString stringWithFormat:@"%@", _hot.latelyFollower];
        NSArray *array2 = @[strNum, @"暂无数据"];
        NSString *str2 = [array2 componentsJoinedByString:@" | "];
        self.lastLabel.text = str2;
    } else if(hot.latelyFollower == nil) {
        NSString *strNum1 = [_hot.retentionRatio stringByAppendingString:@"%读者留存"];
        NSArray *array2 = @[@"暂无数据", strNum1];
        NSString *str2 = [array2 componentsJoinedByString:@" | "];
        self.lastLabel.text = str2;
    } else {
        NSString *strNum1 = [_hot.retentionRatio stringByAppendingString:@"%读者留存"];
        NSString *strNum = [[NSString stringWithFormat:@"%@", _hot.latelyFollower] stringByAppendingString:@"人在追"];
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


@end
