//
//  RootViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/24.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "RootViewController.h"
#import "RunViewCell.h"
#import "ComunityViewCell.h"
#import "GameViewController.h"
#import "ComicViewController.h"
#import "MJRefresh.h"
#import "SearchViewController.h"
#import "BookHelpeViewController.h"
#import "ClassifyViewController.h"

#define kWith self.view.frame.size.width
#define kHeight 50
#define kSHeight self.view.frame.size.height
#define kTHeight kSHeight-kHeight-self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
//追书按钮
@property (nonatomic,strong)UIButton *runButton;
//追书列表
@property (nonatomic,strong)UITableView *runTableView;
//追书数组
@property (nonatomic,strong)NSMutableArray *runArray;
//社区按钮
@property (nonatomic,strong)UIButton *comunityButton;
//社区列表
@property (nonatomic,strong)UITableView *comunityTableView;
//社区数组
@property (nonatomic,strong)NSMutableArray *comunityArray;
//发现按钮
@property (nonatomic,strong)UIButton *findButton;
//发现列表
@property (nonatomic,strong)UITableView *findTableView;
//发现数组
@property (nonatomic,strong)NSMutableArray *findArray;
//下划线
@property (nonatomic,strong)UILabel *redLabel;

@end
//显示标识
int isNum = 1;
@implementation RootViewController

//懒加载
- (NSMutableArray *)runArray{
    if (!_runArray) {
        _runArray = [NSMutableArray array];
    }
    return _runArray;
}
- (NSMutableArray *)comunityArray{
    if (!_comunityArray) {
        _comunityArray = [NSMutableArray array];
    }
    return _comunityArray;
}
- (NSMutableArray *)findArray{
    if (!_findArray) {
        _findArray = [NSMutableArray array];
    }
    return _findArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置导航状态栏
    [self setNavandStatus];
    //布局视图
    [self initViews];
    //注册cell
    [_runTableView registerNib:[UINib nibWithNibName:@"RunViewCell" bundle:nil] forCellReuseIdentifier:@"run"];
    //下拉刷新
    [self downRefresh];
    
}
- (void)downRefresh{
    _runTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //结束刷新
            [_runTableView.mj_header endRefreshing];
        });
    }];
}

//设置导航状态栏
- (void)setNavandStatus{
    self.title = @"天天追书";
    //取消透明
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)];
    self.navigationItem.rightBarButtonItems = @[rightItem,searchItem];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
//搜索标签按钮
- (void)searchAction:(UIBarButtonItem *)sender{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

//添加标签按钮
- (void)addAction:(UIBarButtonItem *)sender{
    
}

//布局视图
- (void)initViews{
    _runButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _runButton.frame = CGRectMake(0, 0, kWith/3, kHeight);
    [_runButton setTitle:@"追书" forState:UIControlStateNormal];
    [_runButton setTintColor:[UIColor grayColor]];
    [_runButton setBackgroundColor:[UIColor whiteColor]];
    [_runButton addTarget:self action:@selector(runAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *labelone = [[UILabel alloc] initWithFrame:CGRectMake(kWith/3, kHeight/3, 1, kHeight/3)];
    labelone.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labelone];
    [self.view addSubview:_runButton];
    
    _comunityButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _comunityButton.frame = CGRectMake(kWith/3, 0, kWith/3, kHeight);
    [_comunityButton setTitle:@"社区" forState:UIControlStateNormal];
    [_comunityButton setTintColor:[UIColor grayColor]];
    [_comunityButton setBackgroundColor:[UIColor whiteColor]];
    [_comunityButton addTarget:self action:@selector(comunityAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(kWith/3*2, kHeight/3, 1, kHeight/3)];
    labeltwo.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labeltwo];
    [self.view addSubview:_comunityButton];
    
    _findButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _findButton.frame = CGRectMake(kWith/3*2, 0, kWith/3, kHeight);
    [_findButton setTitle:@"发现" forState:UIControlStateNormal];
    [_findButton setTintColor:[UIColor grayColor]];
    [_findButton setBackgroundColor:[UIColor whiteColor]];
    [_findButton addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_findButton];
    
    UILabel *labelBotoom = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight, kWith, 1)];
    labelBotoom.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labelBotoom];
    
    _redLabel = [[UILabel alloc] init];
    _redLabel.frame = CGRectMake(0, kHeight, kWith/3, 1);
    _redLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redLabel];
    
    _runTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight) style:UITableViewStylePlain];
    _runTableView.delegate = self;
    _runTableView.dataSource = self;
    [self.view addSubview:_runTableView];
}
//追书按钮点击事件
- (void)runAction:(UIButton *)sender{
    isNum = 1;
    [_comunityTableView removeFromSuperview];
    [_findTableView removeFromSuperview];
    _comunityTableView = nil;
    _findTableView = nil;
    _redLabel.frame = CGRectMake(0, kHeight, kWith/3, 1);
    if (!_runTableView) {
        _runTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight+64) style:UITableViewStylePlain];
        _runTableView.delegate = self;
        _runTableView.dataSource = self;
        [self.view addSubview:_runTableView];
        [_runTableView registerNib:[UINib nibWithNibName:@"RunViewCell" bundle:nil] forCellReuseIdentifier:@"run"];
    }
    //下拉刷新
    [self downRefresh];
}
//社区按钮点击事件
- (void)comunityAction:(UIButton *)sender{
    isNum = 2;
    _redLabel.frame = CGRectMake(kWith/3, kHeight, kWith/3, 1);
    [_runTableView removeFromSuperview];
    _runTableView = nil;
    [_findTableView removeFromSuperview];
    _findTableView = nil;
    self.comunityArray = @[@[@"动态",@"d_icon@2x"],@[@"综合讨论区",@"f_ramble_icon@2x"],@[@"书评区",@"forum_public_review_icon@2x"],@[@"书荒互助区",@"forum_public_help_icon@2x"]].mutableCopy;
    if (!_comunityTableView) {
        _comunityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight + 64) style:UITableViewStylePlain];
        _comunityTableView.delegate = self;
        _comunityTableView.dataSource = self;
        [self.view addSubview:_comunityTableView];
        //[_comunityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"comunity"];
        [_comunityTableView registerNib:[UINib nibWithNibName:@"ComunityViewCell" bundle:nil] forCellReuseIdentifier:@"comunity"];
    }
    
}
//发现按钮点击事件
- (void)findAction:(UIButton *)sender{
    isNum = 3;
    _redLabel.frame = CGRectMake(kWith/3*2, kHeight, kWith/3, 1);
    [_runTableView removeFromSuperview];
    _runTableView = nil;
    [_comunityTableView removeFromSuperview];
    _comunityTableView = nil;
    self.findArray = @[@[@"排行榜",@"rsm_icon_1@2x"],@[@"主题书单",@"rsm_icon_2@2x"],@[@"分类",@"rsm_icon_3@2x"],@[@"听书专区",@"rsm_icon_4@2x"],@[@"游戏中心",@"rsm_icon_7@2x"],@[@"漫画中心",@"rsm_icon_8@2x"]].mutableCopy;
    if (!_findTableView) {
        _findTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight + 64) style:UITableViewStylePlain];
        _findTableView.delegate = self;
        _findTableView.dataSource = self;
        [self.view addSubview:_findTableView];
        [_findTableView registerNib:[UINib nibWithNibName:@"ComunityViewCell" bundle:nil] forCellReuseIdentifier:@"find"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (isNum == 2) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isNum == 2) {
        if (section == 0) {
            return 1;
        }
        if (section == 1) {
            return 3;
        }
        //if (section == 2) {
//            return 3;
//        }
        return 10;
    }
    if (isNum == 3) {
        return 6;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isNum == 1) {
        RunViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"run" forIndexPath:indexPath];
        
        return cell;
    }
    if (isNum == 2) {
        
        ComunityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comunity" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            cell.myImageView.image = [UIImage imageNamed:self.comunityArray[0][1]];
            cell.nameLabel.text = self.comunityArray[0][0];
            return cell;
        }
        if (indexPath.section == 1) {
            cell.myImageView.image = [UIImage imageNamed:self.comunityArray[indexPath.row+1][1]];
            cell.nameLabel.text = self.comunityArray[indexPath.row+1][0];
            return cell;
        }
    }
//        if (indexPath.section == 2) {
//            //我关注的
//        }
        

    //}
//    if (isNum == 2) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comunity" forIndexPath:indexPath];
//        cell.textLabel.text = @"社区";
//        return cell;
//
//    }
    
    ComunityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"find" forIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:self.findArray[indexPath.row][1]];
    cell.nameLabel.text = self.findArray[indexPath.row][0];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"公共社区";
    }
//    if (section == 2) {
//        return @"我的社区";
//    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isNum == 2) {
        if (indexPath.section == 1 && indexPath.row == 2) {
            [self.navigationController pushViewController:[[BookHelpeViewController alloc] init] animated:YES];
        }
    }
    if (isNum == 3) {
        if (indexPath.row == 2) {
            [self.navigationController pushViewController:[[ClassifyViewController alloc] init] animated:YES];
        }
        if (indexPath.row == 4) {
            [self.navigationController pushViewController:[[GameViewController alloc] init] animated:YES];
        }
        if (indexPath.row == 5) {
            [self.navigationController pushViewController:[[ComicViewController alloc] init] animated:YES];
        }
    }
}
@end
