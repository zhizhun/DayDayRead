//
//  ChapterViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/7/4.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ChapterViewController.h"

@interface ChapterViewController ()<UIGestureRecognizerDelegate>

@end
static BOOL isHidden = YES;
@implementation ChapterViewController



- (void)viewWillAppear:(BOOL)animated{
    //dispatch_async(dispatch_get_main_queue(), ^{
    self.myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.myWebView];
        
    
    //适应屏幕
    self.myWebView.scalesPageToFit = YES;
    [self loadString:self.dataObject];
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
//设置导航状态栏
- (void)setNavandStatus{
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
//退出阅读界面
- (void)stopAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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

//轻拍效果
- (void)didAction:(UITapGestureRecognizer *)tap{
    //调用状态栏方法回调
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)loadString:(NSString *)str {
    //1.获取url
    NSURL *url = [NSURL URLWithString:str];
    //2.发送请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.加载内容
    [self.myWebView loadRequest:request];
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