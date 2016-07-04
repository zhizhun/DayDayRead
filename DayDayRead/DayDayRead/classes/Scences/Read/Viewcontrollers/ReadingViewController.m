//
//  ReadingViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/7/1.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "ReadingViewController.h"

@interface ReadingViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
static BOOL isHidden = YES;
@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    //隐藏底视图
    self.bottomView.hidden = YES;
}
//设置导航状态栏
- (void)setNavandStatus{
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
        self.bottomView.hidden = YES;
        isHidden = NO;
        return YES;
    }else{
        self.bottomView.hidden = NO;
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
