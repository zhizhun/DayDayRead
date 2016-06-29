//
//  BookStoreViewController.m
//  项目
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "BookStoreViewController.h"
#import <UIImageView+WebCache.h>
#import "NetWorkRequestManager.h"



@interface BookStoreViewController ()
@property (nonatomic, strong)NSString *dataStr;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLbael;

@property (weak, nonatomic) IBOutlet UILabel *readerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *typeButton1;
@property (weak, nonatomic) IBOutlet UILabel *shortInfoLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong)NSString *textStr;


@end

@implementation BookStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //传值
    [self passValue];
    //
//    [self requestData];
    
   self.navigationItem.title = @"书籍详情";
//    self.navigationController.navigationBar.translucent = NO;
  
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.dataStr = self.textString;
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClicked)];

    
}

- (void)passValue{
    self.titleLbel.text = _commonModel.title;
    self.authorLabel.text = _commonModel.author;
    self.bookNameLbael.text = _commonModel.majorCate;
    self.readerNumLabel.text = [NSString stringWithFormat:@"%ld",_commonModel.latelyFollower];
    self.remainNumLabel.text = [NSString stringWithFormat:@"%@",_commonModel.retentionRatio];
    self.shortInfoLabel.text = _commonModel.shortIntro;
    _commonModel._id = self.textStr;
    NSString *str = _commonModel.cover;
    NSString *str1 = [str substringFromIndex:7];
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:str1]];
    //计算详情高度
    CGRect frame = _shortInfoLabel.frame;
    frame.size.height = [self calculateTextHeightWithCommonModel:_commonModel];
    _shortInfoLabel.frame = frame;
    //给约束赋值
    CGSize size = CGSizeMake(_scrollView.frame.size.width, _shortInfoLabel.frame.size.height+360);
    
    self.backViewHeight.constant  = size.height;

    
}
//- (void)requestData {
//    NSString *str = [NSString stringWithFormat:@"%@,%@,%@",@"http://api.zhuishushenqi.com/book/",_commonModel._id,@"/"];
//    [NetWorkRequestManager requestType:GET urlString:str prama:nil success:^(id data) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",dict);
//            NSArray *array = [dict objectForKey:@"tags"];
//            NSLog(@"%@",array);
//      
//      
//        
//    } fail:^(NSError *error) {
//        
//    }];
//}

- (IBAction)updateButtonAction:(id)sender {
}
- (IBAction)startReadButtonAction:(id)sender {
}

- (void)leftBarButtonItemClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark -- 计算文本高度
- (CGFloat)calculateTextHeightWithCommonModel:(CommonModel *)commonModel
{
    CGSize size = CGSizeMake(_shortInfoLabel.frame.size.width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:24.0f]};
    
    CGRect frame = [commonModel.shortIntro boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}



@end
