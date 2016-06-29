//
//  LeftViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/27.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "LeftViewController.h"
#import "RootViewController.h"
#import "RESideMenu.h"
#import "LoginViewController.h"
#import "SetViewController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width/4

@interface LeftViewController ()

@property (nonatomic,strong)UILabel *myLabel;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1.0];
    //布局视图
    [self initView];
    
    
}
- (void)initView{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWidth, 1)];
    label1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label1];
    
    UIButton *personButton = [UIButton buttonWithType:UIButtonTypeSystem];
    personButton.frame = CGRectMake(kWidth/3, CGRectGetMaxY(label1.frame)+15, kWidth/3, kWidth/3);
    [personButton setBackgroundImage:[UIImage imageNamed:@"hsm_default_avatar@3x"] forState:UIControlStateNormal];
    [personButton addTarget:self action:@selector(personAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:personButton];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(personButton.frame)+15, kWidth, 1)];
    label2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label2];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    homeButton.frame = CGRectMake(kWidth/3, CGRectGetMaxY(label2.frame)+15, kWidth/3, kWidth/3);
    [homeButton setBackgroundImage:[UIImage imageNamed:@"hsm_icon_1@3x"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeButton];
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame), 2, kWidth/3+30)];
    self.myLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myLabel];
    
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(homeButton.frame)+15, kWidth, 1)];
    label3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label3];
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    setButton.frame = CGRectMake(kWidth/3, CGRectGetMaxY(label3.frame)+15, kWidth/3, kWidth/3);
    [setButton setBackgroundImage:[UIImage imageNamed:@"hsm_icon_3@3x"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(settAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(setButton.frame)+15, kWidth, 1)];
    label4.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label4];
}
- (void)personAction:(UIButton *)sender{
    self.myLabel.frame = CGRectMake(0, 51, 2, kWidth/3+30);
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (void)homeAction:(UIButton *)sender{
    self.myLabel.frame = CGRectMake(0, 52+kWidth/3+30, 2, kWidth/3+30);
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (void)settAction:(UIButton *)sender{
    self.myLabel.frame = CGRectMake(0, 53+kWidth/3*2+60, 2, kWidth/3+30);
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[SetViewController alloc] init]] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
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
