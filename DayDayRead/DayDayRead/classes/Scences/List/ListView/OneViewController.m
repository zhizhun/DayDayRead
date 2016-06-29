//
//  OneViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "OneViewController.h"

#import "HotCell.h"
#import "Hot.h"
#import "NetWorkRequestManager.h"
#import <NinaPagerView.h>
#import <NinaBaseView.h>
#import <UIParameter.h>
#import "SingletonList.h"
#import "OneDetailViewController.h"
@interface OneViewController ()

@property (nonatomic, strong) NSMutableArray *allHotArray;

@property (nonatomic, strong) NSString *strOne;

@end

@implementation OneViewController
- (NSMutableArray *)allHotArray {
    
    if (!_allHotArray) {
        _allHotArray = [NSMutableArray array];
        
    }
    return _allHotArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HotCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    SingletonList *list = [SingletonList shareHandle];
    self.strOne = list.array[0];
    
    
    [self requestDataWith];
    
    
}
- (void)requestDataWith {
    
    __weak typeof(self)weakSelf = self;
    
    [NetWorkRequestManager requestType:GET urlString:self.strOne prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"ranking"][@"books"];
        for (NSDictionary *dict in array) {
            Hot *model = [[Hot alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.allHotArray addObject:model];
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"数据请求失败");
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allHotArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Hot *model = self.allHotArray[indexPath.row];
    [cell setHot:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OneDetailViewController *allVC = [[OneDetailViewController alloc] init];
    Hot *hot = self.allHotArray[indexPath.row];
    allVC.hot = hot;
    //UINavigationController  *navVc = [[UINavigationController alloc] initWithRootViewController:allVC];
    //navVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    //[self.view.window.rootViewController presentViewController:navVc animated:YES completion:nil];
    //[navVc.navigationController pushViewController:navVc animated:YES];
    [self.navigationController pushViewController:allVC animated:YES];
    
}


@end