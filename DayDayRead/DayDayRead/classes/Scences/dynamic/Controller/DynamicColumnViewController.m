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
#import "DynamicManager.h"
#import "ArchiverHandle.h"
#import "UserFileHandle.h"
#import "LoginViewController.h"


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
            self.dynamic = [Dynamic new];
            [self.dynamic setValuesForKeysWithDictionary:di];
            [self.dataArray addObject:self.dynamic];
          
          
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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(cell.frame.size.width - 50, 25, 60, 20);
    [button setTitle:@"转发" forState:UIControlStateNormal];
    button.tag = indexPath.row;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor cyanColor];
    [cell.contentView addSubview: button];
    
    BOOL isFav = [[DynamicManager shareDynamicManager]isFavoriteDynamicWith_id:[_dynamic.refTweet objectForKey:@"_id"]];
    if (isFav) {
        [button setTitle:@"已转发" forState:UIControlStateNormal];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicColumnDetailViewController *dynamicDetailVC = [[DynamicColumnDetailViewController alloc] init];
    
    

    Dynamic *dynamic = self.dataArray[indexPath.row];
    dynamicDetailVC.dynamic = dynamic;
    
    [self.navigationController pushViewController:dynamicDetailVC animated:YES];

   }

- (void)buttonClick:(UIButton *)sender {
    
    if ([UserFileHandle selectUserInfo].isLogin) {
        [self favAvactionDynamic:sender];
    }
    else {
        //跳转登录页面
        // 如果没有登录, 点击弹出登录界面
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        // 模态登录界面
        [self.navigationController pushViewController:loginVC animated:YES];

    }

}

- (void)favAvactionDynamic:(UIButton *)sender {
    //先判断是不是登录
    Dynamic *dynamic = self.dataArray[sender.tag];
    BOOL isFav = [[DynamicManager shareDynamicManager]isFavoriteDynamicWith_id:dynamic._id];
    
    
    if (isFav) {
        //取消收藏
        [[DynamicManager shareDynamicManager]deleteDynamic:dynamic];
      
        sender.backgroundColor = [UIColor redColor];
        ;
        return;
    }
    
    [[DynamicManager shareDynamicManager]insertNewDynamic:dynamic];
    
    sender.backgroundColor = [UIColor brownColor];
   
    
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
