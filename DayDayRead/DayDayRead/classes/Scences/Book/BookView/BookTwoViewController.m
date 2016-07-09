//
//  BookTwoViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookTwoViewController.h"
#import "URL.h"
#import "Book.h"
#import "BookCell.h"
#import "NetWorkRequestManager.h"
#import "SingletonBook.h"
#import <NinaBaseView.h>
#import <NinaPagerView.h>
#import <UIParameter.h>
#import "BeforeReadViewController.h"
#import "MJRefresh.h"
@interface BookTwoViewController ()

@property (nonatomic, strong) NSMutableArray *allBookArray;

@property (nonatomic, strong) NSString *string;




@end

static int num = 0;
@implementation BookTwoViewController

- (NSMutableArray *)allBookArray {
    
    if (!_allBookArray) {
        _allBookArray = [NSMutableArray array];
    }
    return _allBookArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self requestData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
   
    
   
  
}



- (void)requestData {
    
    self.view.frame = CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
    
    self.string = [SingletonBook shareHandle].str;
    
    __weak typeof(self)weakSelf = self;
    
    NSString *strr = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book-list?duration=all&sort=created&start=%d&limit=20&", num];
    
    NSString *strAll = [NSString string];
    if ([self.string isEqualToString:@"全部书单"]) {
        
        strAll = strr;
    } else if ([self.string isEqualToString:@"男生"]) {
        
        strAll = [NSString stringWithFormat:@"%@&gender=male", strr];
    } else if ([self.string isEqualToString:@"女生"]) {
        strAll = [NSString stringWithFormat:@"%@&gender=female", strr];
    } else {
        NSString *str = [self.string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        strAll = [NSString stringWithFormat:@"%@&tag=%@",strr, str];
    }
    if (self.allBookArray) {
        [self.allBookArray removeAllObjects];
    }
   
    [NetWorkRequestManager requestType:GET urlString:strAll prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"bookLists"];
        for (NSDictionary *dict in array) {
            Book *book = [[Book alloc] init];
            [book setValuesForKeysWithDictionary:dict];
            [weakSelf.allBookArray addObject:book];
          
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        NSLog(@"数据请求失败");
    }];
    num += 20;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allBookArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Book *book = self.allBookArray[indexPath.row];
    cell.book = book;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BeforeReadViewController *beforeVC = [[BeforeReadViewController alloc] init];
    Book *book = self.allBookArray[indexPath.row];
    beforeVC._id = book._id;
    
    [self.navigationController pushViewController:beforeVC animated:YES];
    
    
}
@end
