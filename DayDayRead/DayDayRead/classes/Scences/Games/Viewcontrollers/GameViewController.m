//
//  GameViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"
#import "NetWorkRequestManager.h"
#import "URL.h"
#import "GameViewCell.h"
#import "PlayViewController.h"
#import "MJRefresh.h"
@interface GameViewController ()<UITableViewDataSource,UITableViewDelegate>

//存储数据数组
@property (nonatomic,strong)NSMutableArray *gameArray;
//显示数据
@property (nonatomic,strong)UITableView *gameTableView;
@end

@implementation GameViewController
//懒加载
- (NSMutableArray *)gameArray{
    if (!_gameArray) {
        _gameArray = [NSMutableArray array];
    }
    return _gameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //布局视图
    self.title = @"游戏中心";
    [self initView];
    //注册cell
    [self.gameTableView registerNib:[UINib nibWithNibName:@"GameViewCell" bundle:nil] forCellReuseIdentifier:@"game"];
    //请求数据
    [self requestData];
    //下拉刷新
    [self downRefresh];
}
- (void)downRefresh{
    _gameTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //结束刷新
            [_gameTableView.mj_header endRefreshing];
        });
    }];
}


- (void)initView{
    self.gameTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:self.gameTableView];
    self.gameTableView.delegate = self;
    self.gameTableView.dataSource = self;
}

- (void)requestData{
    __weak typeof(self) weakself = self;
    [NetWorkRequestManager requestType:GET urlString:GAME_LIST_URL prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"games"];
        for (NSDictionary *dic in array) {
            Game *game = [Game new];
            [game setValuesForKeysWithDictionary:dic];
            [weakself.gameArray addObject:game];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.gameTableView reloadData];
            });
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.gameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GameViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"game" forIndexPath:indexPath];
    Game *game = self.gameArray[indexPath.row];
    cell.game = game;
    PlayViewController *playVC = [[PlayViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:playVC];
    playVC.iosLink = game.iosLink;
    playVC.name = game.name;
    cell.block = ^{
        [self presentViewController:nav animated:YES completion:nil];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
