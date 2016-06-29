//
//  BookHelpeViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/28.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BookHelpeViewController.h"
#import "BookHelpe.h"
#import "BookHelpeViewCell.h"
#import "NetWorkRequestManager.h"
#import "MJRefresh.h"
#import "Tool.h"
#import "DetailViewController.h"
@interface BookHelpeViewController ()<UITableViewDataSource,UITableViewDelegate>
//数组
@property (nonatomic,strong)NSMutableArray *helpeArray;

@property (nonatomic,strong)UITableView *tableView;

@end
static int num = 0;
@implementation BookHelpeViewController

//懒加载
- (NSMutableArray *)helpeArray{
    if (!_helpeArray) {
        _helpeArray = [NSMutableArray array];
    }
    return _helpeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"书荒互助区";
    //布局视图
    [self initView];
    //请求数据
    [self requestData];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"BookHelpeViewCell" bundle:nil] forCellReuseIdentifier:@"help"];
    //下拉刷新
    [self downRefresh];
    //上拉刷新
    [self upRefresh];
    
}
- (void)downRefresh{
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            num = 0;
            [self requestData];
            //结束刷新
            [_tableView.mj_header endRefreshing];
        });
    }];
}

- (void)upRefresh{
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestData];
            //结束刷新
            [_tableView.mj_footer endRefreshing];
        });
    }];
}


- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)requestData{
    [NetWorkRequestManager requestType:GET urlString:[NSString stringWithFormat:@"http://api.zhuishushenqi.com/post/help?duration=all&sort=updated&start=%d&limit=20",num] prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"helps"];
        for (NSDictionary *dic in arr) {
            BookHelpe *book = [BookHelpe new];
            [book setValuesForKeysWithDictionary:dic];
            [self.helpeArray addObject:book];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    num+=20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.helpeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookHelpeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"help" forIndexPath:indexPath];
    BookHelpe *book = self.helpeArray[indexPath.row];
    cell.bookHelpe = book;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookHelpe *help = self.helpeArray[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.book = help;
    [self.navigationController pushViewController:detailVC animated:YES];
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
