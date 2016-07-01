//
//  ComprehensiveDetailViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//http://api.zhuishushenqi.com/post/57747f9662967e7745a17f5b/comment?start=0&limit=50

#import "ComprehensiveDetailViewController.h"
#import "ComprehensiveDetail.h"
#import "ComprehensiveDetailCell.h"
#import "NetWorkRequestManager.h"
#import "MJRefresh.h"
#import <UIImageView+WebCache.h>

@interface ComprehensiveDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *nickImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView * CotableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int temp;
@property (nonatomic, assign)int flag;

@end

@implementation ComprehensiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"综合讨论区";
    [self initView];
    [self downRefresh];
    [self upRefresh];
  
    self.dataArray = [NSMutableArray array];
    self.CotableView.delegate = self;
    self.CotableView.dataSource = self;
    [self.CotableView registerNib:[UINib nibWithNibName:@"ComprehensiveDetailCell" bundle:nil] forCellReuseIdentifier:@"qq"];
    [self requestData];
}

- (void)downRefresh {
    self.CotableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _flag =0;
        [self requestData];
        
        [self.CotableView.mj_header endRefreshing];
        
    }];
    
}
- (void)upRefresh {
    
    self.CotableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestData];
        
        [self.CotableView.mj_footer endRefreshing];
    }];
    
}


- (void)initView {
    
    NSString *urlStr = [_comprehensive.author objectForKey:@"avatar"];
    
    NSString *author = [NSString stringWithFormat:@"%@%@",@"http://api.zhuishushenqi.com",urlStr];
    
    [self.nickImageView sd_setImageWithURL:[NSURL URLWithString:author]];
    NSString *nickname = [_comprehensive.author objectForKey:@"nickname"];
    NSString  *aa = [_comprehensive.author objectForKey:@"lv"];
    
    NSString *str = [nickname stringByAppendingString:@" Lv."];
    
    NSString *str1 = [NSString stringWithFormat:@"%@%@",str,aa];
    
    self.nickNameLabel.text = str1;
    
    self.titleLabel.text = _comprehensive.title;
    
    NSString *timeStr = [_comprehensive.created stringByReplacingOccurrencesOfString:@"T" withString:@" "];
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
}
- (void)requestData {
    NSString *urlStr1 =[NSString stringWithFormat: @"http://api.zhuishushenqi.com/post/%@/comment?start=0&limit=20",__id];
    NSString *urlStr = [NSString stringWithFormat:urlStr1,_flag];
   
    [NetWorkRequestManager requestType:GET urlString:urlStr prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"comments"];
        for (NSDictionary *dic in array) {
            ComprehensiveDetail *model = [ComprehensiveDetail new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.CotableView reloadData];
       });
    } fail:^(NSError *error) {
        
    }];
    _flag +=20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComprehensiveDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qq" forIndexPath:indexPath];
    ComprehensiveDetail *comprehensiveDetail = self.dataArray[indexPath.row];
    cell.comprehensiveDetail = comprehensiveDetail;
  
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
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
