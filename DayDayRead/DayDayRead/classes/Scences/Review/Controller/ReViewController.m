//
//  ReViewController.m
//  TTZS
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "ReViewController.h"
#import "BookReviewOne.h"
#import "BookReViewCell.h"
#import "MJRefresh.h"
#import "Tool.h"
#import "BookDetailReController.h"
#import "NetWorkRequestManager.h"
@interface ReViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *allArray;

@property (nonatomic, strong) UITableView *tableView;




@end

static int num = 0;
@implementation ReViewController

- (NSMutableArray *)allArray {
    
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"书评区";
    //布局视图
    [self initView];
    
    [self requestData];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"BookReViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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


- (void)requestData {
    
    [NetWorkRequestManager requestType:GET urlString:[NSString stringWithFormat:@"http://api.zhuishushenqi.com/post/review?distillate=true&duration=all&sort=updated&type=all&start=%d&limit=20",num] prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"reviews"];
        for (NSDictionary *dic in arr) {
            BookReviewOne *book = [BookReviewOne new];
            [book setValuesForKeysWithDictionary:dic];
            [self.allArray addObject:book];
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
    return self.allArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookReViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BookReviewOne *book = self.allArray[indexPath.row];
    cell.bookReviewOne = book;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookReviewOne *one = self.allArray[indexPath.row];
    CGFloat height = [Tool calculateTextHeightWithMovie:one.title LabelWidth:self.view.frame.size.width font:17.0];
    return height+80;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookDetailReController *detailVC = [[BookDetailReController alloc] init];
    BookReviewOne *one = self.allArray[indexPath.row];
    detailVC.one = one;
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
