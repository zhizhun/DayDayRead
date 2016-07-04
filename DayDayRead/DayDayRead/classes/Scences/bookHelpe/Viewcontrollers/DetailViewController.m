//
//  DetailViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/29.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+WebCache.h>
#import "BookHelpe.h"
#import "URL.h"
#import "DetailViewCell.h"
#import "Detail.h"
#import "NetWorkRequestManager.h"
#import "Tool.h"
#import "MJRefresh.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UILabel *lvLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *allArray;
@end
static int num = 0;
@implementation DetailViewController
//懒加载
- (NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"书荒求助";
    //布局视图
    [self initView];
    //请求数据
    [self loadData];
    //注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:@"DetailViewCell" bundle:nil] forCellReuseIdentifier:@"detail"];
    //下拉刷新
    [self downRefresh];
    //上拉刷新
    [self upRefresh];
}
- (void)downRefresh{
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            num = 0;
            [self loadData];
            //结束刷新
            [_myTableView.mj_header endRefreshing];
        });
    }];
}

- (void)upRefresh{
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadData];
            //结束刷新
            [_myTableView.mj_footer endRefreshing];
        });
    }];
}


- (void)loadData{
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/post/review/%@/comment?start=%d&limit=30",_book._id,num];
    [NetWorkRequestManager requestType:GET urlString:str prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"comments"];
        for (NSDictionary *dic in arr) {
            Detail *model = [Detail new];
            [model setValuesForKeysWithDictionary:dic];
            [self.allArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    num += 30;
}

- (void)initView{
    NSString *avatar = [_book.author objectForKey:@"avatar"];
    NSString *url = [NSString stringWithFormat:@"%@%@",B00K_ROOT,avatar];
    [self.nameImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    NSString *ti = [_book.author objectForKey:@"nickname"];
    NSNumber *lv = [_book.author objectForKey:@"lv"];
    self.lvLabel.text = [NSString stringWithFormat:@"%@ lv.%@",ti,lv];
    
    self.titleLabel.text = _book.title;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
}

//分享
- (IBAction)didShareAction:(id)sender {
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Detail *model = self.allArray[indexPath.row];
    cell.detail = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Detail *detail = self.allArray[indexPath.row];
    CGFloat height = [Tool calculateTextHeightWithMovie:detail.content LabelWidth:self.view.frame.size.width-70 font:15.0];
    return 65+height;
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
