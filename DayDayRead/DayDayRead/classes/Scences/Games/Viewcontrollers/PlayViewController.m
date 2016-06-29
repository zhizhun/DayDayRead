//
//  PlayViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航状态栏
    [self setNavandStatus];
    //布局视图
    [self initView];
}
- (void)initView{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self loadString:self.iosLink];
    [self.webView goBack];
}
- (void)loadString:(NSString *)str {
    //1.获取url
    NSURL *url = [NSURL URLWithString:str];
    //2.发送请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.加载内容
    [self.webView loadRequest:request];
}

//设置导航状态栏
- (void)setNavandStatus{
    self.title = self.name;
    //取消透明
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)rightAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
