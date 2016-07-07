//
//  ReadingViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/7/1.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ReadingViewController.h"
#import "Bookfrom.h"
#import "Chapter.h"
#import "NetWorkRequestManager.h"
#import "ChapterViewController.h"

@interface ReadingViewController ()<UIPageViewControllerDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIWebView *myWebView;
@property (nonatomic,strong)UIPageViewController *pageController;
@property (nonatomic,strong)NSMutableArray *pageContent;

//搜狗地址
@property (nonatomic,copy)NSString *s_url;
//宜搜地址
@property (nonatomic,copy)NSString *y_url;
//书哈哈小说网地址
@property (nonatomic,copy)NSString *hh_url;
//晋江文学城地址
@property (nonatomic,copy)NSString *jj_url;
//笔趣阁地址
@property (nonatomic,copy)NSString *bb_url;
//混混小说网地址
@property (nonatomic,copy)NSString *hun_url;
//365小说地址
@property (nonatomic,copy)NSString *san_url;
//69书吧地址
@property (nonatomic,copy)NSString *liu_url;
//起点中文网地址
@property (nonatomic,copy)NSString *qi_url;
//17K小说网地址
@property (nonatomic,copy)NSString *kk_url;
//请看小说网地址
@property (nonatomic,copy)NSString *qk_url;
//乐读窝地址
@property (nonatomic,copy)NSString *ld_url;
//00小说地址
@property (nonatomic,copy)NSString *ling_url;
//13小说地址
@property (nonatomic,copy)NSString *th_url;
//2月天地址
@property (nonatomic,copy)NSString *da_url;

@end
static BOOL isHidden = YES;
@implementation ReadingViewController
//懒加载
- (NSMutableArray *)pageContent{
    if (!_pageContent) {
        _pageContent = [NSMutableArray array];
    }
    return _pageContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    NSLog(@"%@",self._id);
    //请求数据
    [self requestData];

}
//设置pageController
- (void)initPageViewController{
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionInterPageSpacingKey];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    self.pageController.dataSource = self;
    //大小
    [[_pageController view] setFrame:self.view.bounds];
    ChapterViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    [_pageController didMoveToParentViewController:self];
}
//两个遍历方法
//返回视图控制器
- (ChapterViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (self.pageContent.count == 0 || index>= self.pageContent.count) {
        return nil;
    }
    ChapterViewController *chapterVC = [[ChapterViewController alloc] init];
    chapterVC.dataObject = self.pageContent[index];
    return chapterVC;
}
//返回下标
- (NSUInteger)indexOfViewController:(ChapterViewController *)viewController{
    return [self.pageContent indexOfObject:viewController.dataObject];
}

#pragma mark - UIPageViewControllerDataSource
//上一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(ChapterViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
//下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(ChapterViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == self.pageContent.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
//请求数据
- (void)requestData{
    __weak typeof(self)weakself = self;
    
    [NetWorkRequestManager requestType:GET urlString:[NSString stringWithFormat:@"http://api.zhuishushenqi.com/toc?view=summary&book=%@",self._id] prama:nil success:^(id data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            Bookfrom *boo = [Bookfrom new];
            [boo setValuesForKeysWithDictionary:dic];
            if ([boo.name isEqualToString:@"宜搜小说"]){
                _y_url = boo.link;
            }else if ([boo.name isEqualToString:@"搜狗"]) {
                _s_url = boo.link;
            }else if ([boo.name isEqualToString:@"书哈哈小说网"]){
                _hh_url = boo.link;
            }else if ([boo.name isEqualToString:@"晋江文学城"]){
                _jj_url = boo.link;
            }else if ([boo.name isEqualToString:@"笔趣阁"]){
                _bb_url = boo.link;
            }else if ([boo.name isEqualToString:@"混混小说网"]){
                _hun_url = boo.link;
            }else if ([boo.name isEqualToString:@"365小说"]){
                _san_url = boo.link;
            }else if ([boo.name isEqualToString:@"69书吧"]){
                _liu_url = boo.link;
            }else if ([boo.name isEqualToString:@"起点中文网"]){
                _qi_url = boo.link;
            }else if ([boo.name isEqualToString:@"17K小说网"]){
                _kk_url = boo.link;
            }else if ([boo.name isEqualToString:@"请看小说网"]){
                _qk_url = boo.link;
            }else if ([boo.name isEqualToString:@"乐读窝"]){
                _ld_url = boo.link;
            }else if ([boo.name isEqualToString:@"00小说"]){
                _ling_url = boo.link;
            }else if ([boo.name isEqualToString:@"13小说"]){
                _th_url = boo.link;
            }else if ([boo.name isEqualToString:@"2月天"]){
                _da_url = boo.link;
            }
        }
        if (_y_url.length>0){
            [NetWorkRequestManager requestType:GET urlString:_y_url prama:nil success:^(id data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *ar = [dict objectForKey:@"items"];
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dicc in ar) {
                    NSString *str = [dicc objectForKey:@"curl"];
                    [array addObject:str];
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.pageContent = array;
                    //设置pageController
                    [self initPageViewController];
                });
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        else if (_s_url.length>0) {
            [NetWorkRequestManager requestType:GET urlString:_s_url prama:nil success:^(id data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *ar = [dict objectForKey:@"chapter"];
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dicc in ar) {
                    NSString *str = [dicc objectForKey:@"url"];
                    [array addObject:str];
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.pageContent = array;
                    //设置pageController
                    [self initPageViewController];
                });
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
            }];

        }else if (_hh_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_hh_url];
            });
        }else if (_jj_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_jj_url];
            });
        }else if (_bb_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_bb_url];
            });
        }else if (_hun_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_hun_url];
            });
        }else if (_san_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_san_url];
            });
        }else if (_liu_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_liu_url];
            });
        }else if (_qi_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_qi_url];
            });
        }else if (_kk_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_kk_url];
            });
        }else if (_qk_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_qk_url];
            });
        }else if (_ld_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_ld_url];
            });
        }else if (_ling_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_ling_url];
            });
        }else if (_th_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_th_url];
            });
        }else if (_da_url.length>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself createWebWithString:_da_url];
            });
        }
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//创建webview
- (void)createWebWithString:(NSString *)str{
    self.myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.myWebView];
    
    //适应屏幕
    self.myWebView.scalesPageToFit = YES;
    [self loadString:str];
    [self.myWebView goBack];
    //点击效果
    _myWebView.scrollView.bounces = NO;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didAction:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [_myWebView addGestureRecognizer:singleTap];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)loadString:(NSString *)str {
    //1.获取url
    NSURL *url = [NSURL URLWithString:str];
    //2.发送请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.加载内容
    [self.myWebView loadRequest:request];
}


//设置导航状态栏
- (void)setNavandStatus{
    self.title = @"天天追书";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    if (isHidden) {
        self.navigationController.navigationBarHidden = YES;
        isHidden = NO;
        return YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
        [self setNavandStatus];
        isHidden = YES;
        return NO;
    }
}

//退出阅读界面
- (void)stopAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//轻拍效果
- (void)didAction:(UITapGestureRecognizer *)tap{
    //调用状态栏方法回调
    [self setNeedsStatusBarAppearanceUpdate];
}
//轻拍页面效果
- (IBAction)didTapAction:(UITapGestureRecognizer *)sender {
    //调用状态栏方法回调
    [self setNeedsStatusBarAppearanceUpdate];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
