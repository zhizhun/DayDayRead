//
//  DynamicColumnDetailViewController.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicColumnDetailViewController.h"
#import "DynamicCell.h"
#import <UIImageView+WebCache.h>

@interface DynamicColumnDetailViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *nickNameImageView;
@property (weak, nonatomic) IBOutlet UILabel *NickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeght;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DynamicColumnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"综合讨论区";
    [self initLayout];
    [self initView];
}
- (void)initView{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClicked)];

}
- (void)leftBarButtonItemClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)initLayout {
    
    
    NSString *imageStr = [_dynamic.from objectForKey:@"avatar"];
    NSString *urlStr= @"http://statics.zhuishushenqi.com/";
    NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
    
    [self.nickNameImageView sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
    NSString *nickname = [_dynamic.from objectForKey:@"nickname"];
    NSString *lv = [_dynamic.from objectForKey:@"lv"];
    self.NickNameLabel.text = [NSString stringWithFormat:@"%@%@%@",nickname,@" Lv.",lv];
    
    NSString *title = [_dynamic.refTweet objectForKey:@"title"];
    self.titleLabel.text = title;
    NSString *content = [_dynamic.refTweet objectForKey:@"content"];
    self.contentLabel.text = content;
  
    NSString *timeStr = [_dynamic.refTweet  objectForKey:@"created"];
    
    NSString *timeStr1 = [timeStr substringToIndex:10];
    self.timeLabel.text =timeStr1;
//计算详情高度
    CGRect frame = _contentLabel.frame;
    frame.size.height = [self calcuateTextHeightWithDynamic:_dynamic];
    _contentLabel.frame = frame;
    //给约束赋值
    CGSize size = CGSizeMake(_scrollView.frame.size.width, _contentLabel.frame.size.height +360);
    self.contentViewHeght.constant = size.height;
}
#pragma mark -- 计算文本高度

- (CGFloat)calcuateTextHeightWithDynamic:(Dynamic*)dyanmic {
    CGSize size = CGSizeMake(_contentLabel.frame.size.width, 1000000);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    CGRect frame = [[_dynamic.refTweet objectForKey:@"content"]boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return frame.size.height;
    
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
