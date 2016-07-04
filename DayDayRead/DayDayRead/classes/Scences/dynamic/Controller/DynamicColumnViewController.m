//
//  DynamicColumnViewController.m
//  项目
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicColumnViewController.h"
#import "Dynamic.h"
#import "DynamicCell.h"
#import "NetWorkRequestManager.h"
#import "DynamicColumnDetailViewController.h"
#import "MJRefresh.h"
#import "Tool.h"

@interface DynamicColumnViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign) int flag;



@end

@implementation DynamicColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    [self initView];
    [self requestData];
    [self downRefresh];
    [self upRefresh];
    // Do any additional setup after loading the view.
}
- (void)downRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _flag = 0;
        [self requestData];
        [self.tableView.mj_header endRefreshing];
        
    }];
    

    
}
- (void)upRefresh {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestData];
        [self.tableView.mj_footer endRefreshing];
    }];

    
}
- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    //注册cell
    [self.tableView registerClass:[DynamicCell class] forCellReuseIdentifier:@"cell"];
}
- (void)requestData {
    
    NSString *URLStr = @"http://api.zhuishushenqi.com/user/twitter/timeline/56a38446818fb11e5ff8de65?token=mdA31yLC0wNyZnG61Z6MimpI";
    [NetWorkRequestManager requestType:GET urlString:URLStr prama:nil success:^(id data) {
        __weak typeof(DynamicColumnViewController*)dynamicVc = self;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"timeline"];
        for (NSDictionary *dic in array) {
            NSDictionary *di = [dic objectForKey:@"tweet"];
            Dynamic *dynamic = [Dynamic new];
            [dynamic setValuesForKeysWithDictionary:di];
            [self.dataArray addObject:dynamic];
          
          
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [dynamicVc.tableView reloadData ];
           
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dynamic = self.dataArray[indexPath.row];
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicColumnDetailViewController *dynamicDetailVC = [[DynamicColumnDetailViewController alloc] init];
    
    

    Dynamic *dynamic = self.dataArray[indexPath.row];
    dynamicDetailVC.dynamic = dynamic;
    
    [self.navigationController pushViewController:dynamicDetailVC animated:YES];

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
