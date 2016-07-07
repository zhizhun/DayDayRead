//
//  DynamicHotViewController.m
//  项目
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicHotViewController.h"
#import "DynamicHot.h"
#import "DynamicHotCell.h"
#import "NetWorkRequestManager.h"
#import "DynamicHotDetailViewController.h"

@interface DynamicHotViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation DynamicHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self initView];
    [self requestData];
    // Do any additional setup after loading the view.
}
- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    //注册cell
    [self.tableView registerClass:[DynamicHotCell class] forCellReuseIdentifier:@"cell"];
}
- (void)requestData {
    NSString *URLStr = @"http://api.zhuishushenqi.com/user/twitter/hottweets";
    [NetWorkRequestManager requestType:GET urlString:URLStr prama:nil success:^(id data) {
        __weak typeof(DynamicHotViewController*)dynamicHotVc = self;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"tweets"];
        for (NSDictionary *dic in array) {
          
            DynamicHot *dynamicHot = [DynamicHot new];
            [dynamicHot setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:dynamicHot];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [dynamicHotVc.tableView reloadData ];
       
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
    DynamicHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dynamicHot = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicHotDetailViewController *dynamicHotDetailVC = [[DynamicHotDetailViewController alloc] init];
    
    
    DynamicHot *dynamicHot = self.dataArray[indexPath.row];
    dynamicHotDetailVC.dynamicHot = dynamicHot;
    [self.navigationController pushViewController:dynamicHotDetailVC animated:YES];
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
