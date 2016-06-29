//
//  ResultsViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/27.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ResultsViewController.h"
#import "ResultsViewCell.h"
#import "Result.h"
#import "NetWorkRequestManager.h"
#import "URL.h"
@interface ResultsViewController ()

@property (nonatomic,strong)NSMutableArray *resultArray;

@end

@implementation ResultsViewController
//懒加载
- (NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self loadData];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultsViewCell" bundle:nil] forCellReuseIdentifier:@"result"];
}
- (void)loadData{
    
    [NetWorkRequestManager requestType:GET urlString:[NSString stringWithFormat:@"%@%@",QUERY_LIST_URL,[self.query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"books"];
        for (NSDictionary *dic in arr) {
            Result *model = [Result new];
            [model setValuesForKeysWithDictionary:dic];
            [self.resultArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"result" forIndexPath:indexPath];
    Result *result = self.resultArray[indexPath.row];
    cell.result = result;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
