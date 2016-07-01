//
//  TwoViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "TwoViewController.h"
#import "HotCell.h"
#import "Hot.h"
#import "NetWorkRequestManager.h"
#import <NinaPagerView.h>
#import <NinaBaseView.h>
#import <UIParameter.h>
#import "SingletonList.h"
#import "BeforeReadViewController.h"
@interface TwoViewController ()

@property (nonatomic, strong) NSMutableArray *allHotArray;

@property (nonatomic, strong) NSString *strOne;

@end

@implementation TwoViewController
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
    self.view.frame = CGRectMake(0, 64, FUll_VIEW_WIDTH, FUll_VIEW_HEIGHT);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HotCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    SingletonList *list = [SingletonList shareHandle];
    self.strOne = list.array[1];
    
    
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
    
    BeforeReadViewController *beforeVC = [[BeforeReadViewController alloc] init];
    Hot *book = self.allHotArray[indexPath.row];
    beforeVC._id = book._id;
    [self.navigationController pushViewController:beforeVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
