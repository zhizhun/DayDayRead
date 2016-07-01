//
//  ComprehensiveViewController.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//http://api.zhuishushenqi.com/post/by-block?block=ramble&duration=all&sort=updated&start=0&limit=20
//http://api.zhuishushenqi.com/post/help?duration=all&sort=updated&start=%d&limit=20

#import "ComprehensiveViewController.h"
#import "Comprehensive.h"
#import "ComprehensiveCell.h"
#import "NetWorkRequestManager.h"
#import "MJRefresh.h"
#import "ComprehensiveDetailViewController.h"

@interface ComprehensiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int index;


@end

@implementation ComprehensiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"综合讨论区";
  
    
    self.dataArray = [NSMutableArray array];
    [self initView];
    [self requestData];
    [self downRefresh];
    [self upRfresh];
}

- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.view addSubview:self.tableView];
    
    //注册cell
//    [self.tableView registerClass:[ComprehensiveCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ComprehensiveCell" bundle:nil] forCellReuseIdentifier:@"aa"];
    
}
- (void)downRefresh {
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.index = 0;
            [self requestData];
            //结束刷新
            [_tableView.mj_header endRefreshing];
            
        });
    }];
    
}
- (void)upRfresh {
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [self requestData];
            //结束刷新
            
            [_tableView.mj_footer endRefreshing];
        });
    }];
    
}
//解析数据
- (void)requestData {
    [NetWorkRequestManager requestType:GET urlString:[NSString stringWithFormat:@"%@%d",@"http://api.zhuishushenqi.com/post/by-block?block=ramble&duration=all&sort=updated&start=0&limit=20",_index] prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"posts"];
        for (NSDictionary *dic in arr) {
            Comprehensive *comprehensive = [Comprehensive new];
            [comprehensive setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:comprehensive];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    _index+=20;

    
}
#pragma tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComprehensiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    Comprehensive *comprehensive = self.dataArray[indexPath.row];
    cell.comprehensive = comprehensive;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ComprehensiveDetailViewController *detailVC = [[ComprehensiveDetailViewController alloc] init];
    Comprehensive *comprehensive = [self.dataArray objectAtIndex:indexPath.row];
    detailVC.comprehensive = comprehensive;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
