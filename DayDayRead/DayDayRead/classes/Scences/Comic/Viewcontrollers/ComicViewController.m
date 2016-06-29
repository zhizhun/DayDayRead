//
//  ComicViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ComicViewController.h"
#import "ComicViewCell.h"
#import "Comic.h"
#import "NetWorkRequestManager.h"
#import "URL.h"
#import "MJRefresh.h"
@interface ComicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *comicArray;
@property (nonatomic,strong)UITableView *comicTableView;

@end

@implementation ComicViewController

//懒加载
- (NSMutableArray *)comicArray{
    if (!_comicArray) {
        _comicArray = [NSMutableArray array];
    }
    return _comicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //布局视图
    self.title = @"漫画中心";
    [self initView];
    //请求数据
    [self requestData];
    //注册cell
    [self.comicTableView registerNib:[UINib nibWithNibName:@"ComicViewCell" bundle:nil] forCellReuseIdentifier:@"comic"];
    //下拉刷新
    [self downRefresh];
}
- (void)downRefresh{
    _comicTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //结束刷新
            [_comicTableView.mj_header endRefreshing];
        });
    }];
}


- (void)initView{
    self.comicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:self.comicTableView];
    self.comicTableView.delegate = self;
    self.comicTableView.dataSource = self;
}

- (void)requestData{
    [NetWorkRequestManager requestType:GET urlString:COMIC_LIST_URL prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"info"];
        for (NSDictionary *dic in arr) {
            Comic *comic = [Comic new];
            [comic setValuesForKeysWithDictionary:dic];
            [self.comicArray addObject:comic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.comicTableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comicArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ComicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comic" forIndexPath:indexPath];
    Comic *comic = self.comicArray[indexPath.row];
    cell.comic = comic;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确认下载" message:@"即将开始下载《漫画岛》APP，欣赏60000+本精彩漫画" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = @"https://itunes.apple.com/cn/app/man-hua-dao-chao-quan-er-ci/id704407904?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    [alertVC addAction:cancleAction];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


@end
