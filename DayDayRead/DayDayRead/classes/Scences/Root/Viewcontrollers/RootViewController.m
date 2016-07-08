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
#import "BookAllViewController.h"
#import "ListViewController.h"
#import "DynamicViewController.h"
#import "ComprehensiveViewController.h"
#import "ReViewController.h"
#import "bookDetail.h"
#import "BookReadManager.h"
#import <UIImageView+WebCache.h>
#import "BeforeReadViewController.h"
#import "JXLDayAndNightMode.h"
#import "Danli.h"
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

#warning 此处添加代码
@property (nonatomic, strong) NSMutableArray *bookDetails;


@end


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
- (void)viewWillAppear:(BOOL)animated{

    
    self.bookDetails = [[BookReadManager shareBookReadManager] selectAllBooks];
    [self.runTableView reloadData];
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置导航状态栏
    [self setNavandStatus];
    //布局视图
    [self initViews];
    [_runTableView jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor blackColor];
        
    }];
    self.comunityArray = @[@[@"动态",@"d_icon@2x"],@[@"综合讨论区",@"f_ramble_icon@2x"],@[@"书评区",@"forum_public_review_icon@2x"],@[@"书荒互助区",@"forum_public_help_icon@2x"]].mutableCopy;
    self.findArray = @[@[@"排行榜",@"rsm_icon_1@2x"],@[@"主题书单",@"rsm_icon_2@2x"],@[@"分类",@"rsm_icon_3@2x"],@[@"听书专区",@"rsm_icon_4@2x"],@[@"游戏中心",@"rsm_icon_7@2x"],@[@"漫画中心",@"rsm_icon_8@2x"]].mutableCopy;
    //注册cell
    if ([Danli shareDanli].num == 1) {
        [_runTableView registerNib:[UINib nibWithNibName:@"RunViewCell" bundle:nil] forCellReuseIdentifier:@"run"];
    }
    if ([Danli shareDanli].num == 2) {
        _redLabel.frame = CGRectMake(kWith/3, kHeight, kWith/3, 1);
        [_runTableView removeFromSuperview];
        _runTableView = nil;
        [_findTableView removeFromSuperview];
        _findTableView = nil;
        
        if (!_comunityTableView) {
            _comunityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight + 64) style:UITableViewStylePlain];
            _comunityTableView.delegate = self;
            _comunityTableView.dataSource = self;
            [_comunityTableView jxl_setDayMode:^(UIView *view) {
                
                view.backgroundColor = [UIColor whiteColor];
            } nightMode:^(UIView *view) {
                
                view.backgroundColor = [UIColor blackColor];
                
            }];
            [self.view addSubview:_comunityTableView];
            //[_comunityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"comunity"];
            [_comunityTableView registerNib:[UINib nibWithNibName:@"ComunityViewCell" bundle:nil] forCellReuseIdentifier:@"comunity"];
        }
    }
    if ([Danli shareDanli].num == 3) {
        _redLabel.frame = CGRectMake(kWith/3*2, kHeight, kWith/3, 1);
        [_runTableView removeFromSuperview];
        _runTableView = nil;
        [_comunityTableView removeFromSuperview];
        _comunityTableView = nil;
        
        if (!_findTableView) {
            _findTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight + 64) style:UITableViewStylePlain];
            _findTableView.delegate = self;
            _findTableView.dataSource = self;
            [_findTableView jxl_setDayMode:^(UIView *view) {
                
                view.backgroundColor = [UIColor whiteColor];
            } nightMode:^(UIView *view) {
                
                view.backgroundColor = [UIColor blackColor];
                
            }];
            [self.view addSubview:_findTableView];
            [_findTableView registerNib:[UINib nibWithNibName:@"ComunityViewCell" bundle:nil] forCellReuseIdentifier:@"find"];
        }
    }
    //下拉刷新
    [self downRefresh];
    
    
}


- (void)downRefresh{
    _runTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //结束刷新
            
            self.bookDetails = [[BookReadManager shareBookReadManager] selectAllBooks];
            [self.runTableView reloadData];
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
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)];
    self.navigationItem.rightBarButtonItem = searchItem;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
//搜索标签按钮
- (void)searchAction:(UIBarButtonItem *)sender{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}


//布局视图
- (void)initViews{
    _runButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _runButton.frame = CGRectMake(0, 0, kWith/3, kHeight);
    [_runButton setTitle:@"追书" forState:UIControlStateNormal];
    [_runButton setTintColor:[UIColor grayColor]];
    [_runButton setBackgroundColor:[UIColor whiteColor]];
    [_runButton jxl_setDayMode:^(UIView *view) {
        
        UIButton *setButton = (UIButton *)view;
        setButton.backgroundColor = [UIColor whiteColor];
        [setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } nightMode:^(UIView *view) {
        
        UIButton *setButton = (UIButton *)view;
        setButton.backgroundColor = [UIColor blackColor];
        [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }];
    
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
    [_comunityButton jxl_setDayMode:^(UIView *view) {
        
        UIButton *setButton = (UIButton *)view;
        setButton.backgroundColor = [UIColor whiteColor];
        [setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } nightMode:^(UIView *view) {
        
        UIButton *setButton = (UIButton *)view;
        setButton.backgroundColor = [UIColor blackColor];
        [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }];
    
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
    [_findButton jxl_setDayMode:^(UIView *view) {
        
        UIButton *setButton = (UIButton *)view;
        setButton.backgroundColor = [UIColor whiteColor];
        [setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } nightMode:^(UIView *view) {
        
        UIButton *setButton = (UIButton *)view;
        setButton.backgroundColor = [UIColor blackColor];
        [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }];
    
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
    [_runTableView jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor blackColor];
        
    }];
    
    [self.view addSubview:_runTableView];
}
//追书按钮点击事件
- (void)runAction:(UIButton *)sender{
    [Danli shareDanli].num = 1;
    [_comunityTableView removeFromSuperview];
    [_findTableView removeFromSuperview];
    _comunityTableView = nil;
    _findTableView = nil;
    _redLabel.frame = CGRectMake(0, kHeight, kWith/3, 1);
    if (!_runTableView) {
        _runTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight+64) style:UITableViewStylePlain];
        _runTableView.delegate = self;
        _runTableView.dataSource = self;
        [_runTableView jxl_setDayMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor blackColor];
            
        }];
        [self.view addSubview:_runTableView];
        [_runTableView registerNib:[UINib nibWithNibName:@"RunViewCell" bundle:nil] forCellReuseIdentifier:@"run"];
    }
    //下拉刷新
    [self downRefresh];
}
//社区按钮点击事件
- (void)comunityAction:(UIButton *)sender{
    [Danli shareDanli].num = 2;
    _redLabel.frame = CGRectMake(kWith/3, kHeight, kWith/3, 1);
    [_runTableView removeFromSuperview];
    _runTableView = nil;
    [_findTableView removeFromSuperview];
    _findTableView = nil;
    
    if (!_comunityTableView) {
        _comunityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight + 64) style:UITableViewStylePlain];
        _comunityTableView.delegate = self;
        _comunityTableView.dataSource = self;
        [_comunityTableView jxl_setDayMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor blackColor];
            
        }];
        [self.view addSubview:_comunityTableView];
        //[_comunityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"comunity"];
        [_comunityTableView registerNib:[UINib nibWithNibName:@"ComunityViewCell" bundle:nil] forCellReuseIdentifier:@"comunity"];
    }
    
}
//发现按钮点击事件
- (void)findAction:(UIButton *)sender{
    [Danli shareDanli].num  = 3;
    _redLabel.frame = CGRectMake(kWith/3*2, kHeight, kWith/3, 1);
    [_runTableView removeFromSuperview];
    _runTableView = nil;
    [_comunityTableView removeFromSuperview];
    _comunityTableView = nil;
    
    if (!_findTableView) {
        _findTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight+1, kWith, kTHeight + 64) style:UITableViewStylePlain];
        _findTableView.delegate = self;
        _findTableView.dataSource = self;
        [_findTableView jxl_setDayMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor blackColor];
            
        }];
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
    if ([Danli shareDanli].num  == 2) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([Danli shareDanli].num  == 2) {
        if (section == 0) {
            return 1;
        }
        if (section == 1) {
            return 3;
        }
        //if (section == 2) {
        //            return 3;
        //        }
    }
    if ([Danli shareDanli].num  == 3) {
        return 6;
    }
    if (self.bookDetails.count == 0) {
        return 1;
    }
    return self.bookDetails.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([Danli shareDanli].num  == 1) {
        if (self.bookDetails.count == 0) {
            
            RunViewCell *cell = [self.runTableView dequeueReusableCellWithIdentifier:@"run" forIndexPath:indexPath];
#warning 此处添加代码
            
            cell.bookTitleLabel.text = @"请加入书籍";
            return cell;
        }
        
        RunViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"run" forIndexPath:indexPath];
#warning 此处添加代码
        bookDetail *book = self.bookDetails[indexPath.row];
        cell.book = book;
        return cell;
    }
    if ([Danli shareDanli].num  == 2) {
        
        ComunityViewCell *cell = [self.comunityTableView  dequeueReusableCellWithIdentifier:@"comunity" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ComunityViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"comunity"];
        }
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
    
    ComunityViewCell *cell = [self.findTableView dequeueReusableCellWithIdentifier:@"find" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ComunityViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"find"];
    }
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
    if ([Danli shareDanli].num == 1) {
        return 90;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([Danli shareDanli].num  == 2) {
        if (indexPath.section == 0) {
            [self.navigationController pushViewController:[[DynamicViewController alloc] init] animated:YES];
            
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            [self.navigationController pushViewController:[[ReViewController alloc] init] animated:YES];
        }
        if (indexPath.section == 1 && indexPath.row == 2) {
            [self.navigationController pushViewController:[[BookHelpeViewController alloc] init] animated:YES];
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            [self.navigationController pushViewController:[[ComprehensiveViewController alloc] init] animated:YES];
        }
        
    }
    if ([Danli shareDanli].num  == 3) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[ListViewController alloc] init] animated:YES];
        }
        if (indexPath.row == 2) {
            [self.navigationController pushViewController:[[ClassifyViewController alloc] init] animated:YES];
        }
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[BookAllViewController alloc] init] animated:YES];
        }
        if (indexPath.row == 4) {
            [self.navigationController pushViewController:[[GameViewController alloc] init] animated:YES];
        }
        if (indexPath.row == 5) {
            [self.navigationController pushViewController:[[ComicViewController alloc] init] animated:YES];
        }
    }
    if ([Danli shareDanli].num  == 1) {
        
        
        if (self.bookDetails.count == 0) {
            
        } else {
            BeforeReadViewController *readVC = [[BeforeReadViewController alloc] init];
            bookDetail *book = self.bookDetails[indexPath.row];
            readVC._id = book._id;
            [self.navigationController pushViewController:readVC animated:YES];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([Danli shareDanli].num == 1) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 取出对应的元素
        if (self.bookDetails.count == 0) {
            
        }
        bookDetail *book = self.bookDetails[indexPath.row];
        [self.bookDetails removeObject:book];
        [[BookReadManager shareBookReadManager] deleteBook:book];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}
@end
