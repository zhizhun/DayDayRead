//
//  BookDetailReController.m
//  TTZS
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookDetailReController.h"
#import "BookReviewOne.h"
#import "NetWorkRequestManager.h"
#import "BookReviewHeader.h"
#import "ReViewHeaderCell.h"
#import "URL.h"
#import "BookReviewThr.h"
#import "BookReViewDTCell.h"
#import "Tool.h"
#import "MJRefresh.h"
#import "BeforeReadViewController.h"
@interface BookDetailReController ()

@property (nonatomic, strong) NSMutableArray *allArray;

@property (nonatomic, strong) NSMutableArray *dictArray;


@end

static int num = 0;
@implementation BookDetailReController


- (NSMutableArray *)allArray {
    
    if (!_allArray) {
        _allArray = [NSMutableArray array];
        
    }
    return _allArray;
}

- (NSMutableArray *)dictArray {
    
    if (!_dictArray) {
        _dictArray = [NSMutableArray array];
        
    }
    return _dictArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self requestData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReViewHeaderCell" bundle:nil] forCellReuseIdentifier:@"header"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookReViewDTCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //下拉刷新
    [self downRefresh];
    //上拉刷新
    [self upRefresh];
}
- (void)downRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            num = 0;
            [self requestData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
        });
    }];
}

- (void)upRefresh{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestData];
            //结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}


- (void)requestData {
    
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/post/review/%@/comment?start=%d&limit=50",_one._id, num];
    [NetWorkRequestManager requestType:GET urlString:str prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"comments"];
        for (NSDictionary *dic in array) {
            BookReviewThr *model = [BookReviewThr new];
            [model setValuesForKeysWithDictionary:dic];
            [self.allArray addObject:model];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    num += 30;

}

- (void)initView {
    
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/post/review/%@",_one._id];
    [NetWorkRequestManager requestType:GET urlString:str prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic = [dict objectForKey:@"review"];
        BookReviewHeader *header = [BookReviewHeader new];
        
        [header setValuesForKeysWithDictionary:dic];
        
        [self.dictArray addObject:header];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.dictArray.count;
    }
    return self.allArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ReViewHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"header" forIndexPath:indexPath];
        
        BookReviewHeader *header = self.dictArray[indexPath.row];
        headerCell.header = header;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(self.view.frame.size.width-70, 20, 60, 30);
        [button setImage:[UIImage imageNamed:@"forum_book_entry@3x"] forState:UIControlStateNormal];
        button.tintColor = [UIColor grayColor];
        [button addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [headerCell addSubview:button];
        return headerCell;
        
    }
    BookReViewDTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BookReviewThr *thr = self.allArray[indexPath.row];
    cell.thr = thr;
    
    return cell;
}

- (void)nextAction {
    
    BookReviewOne *one = self.dictArray[0];
    BeforeReadViewController *beforeVC = [[BeforeReadViewController alloc] init];
    beforeVC._id = one._id;
    NSLog(@"-----%@", one._id);
    [self.navigationController pushViewController:beforeVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        BookReviewHeader *header = self.dictArray[indexPath.row];
       
        
        CGFloat contentH = [Tool calculateTextHeightWithMovie:header.content LabelWidth:self.view.frame.size.width-70 font:16.0];
            CGFloat titleH = [Tool calculateTextHeightWithMovie:header.title LabelWidth:self.view.frame.size.width-70 font:20.0];
            CGFloat authorH = [Tool calculateTextHeightWithMovie:[header.author objectForKey:@"nickname"] LabelWidth:self.view.frame.size.width-70 font:17.0];
        return contentH+authorH+titleH+165;
        
    }
    
    BookReviewThr *detail = self.allArray[indexPath.row];
    CGFloat height = [Tool calculateTextHeightWithMovie:detail.content LabelWidth:self.view.frame.size.width-70 font:15.0];
    return 65+height;
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
