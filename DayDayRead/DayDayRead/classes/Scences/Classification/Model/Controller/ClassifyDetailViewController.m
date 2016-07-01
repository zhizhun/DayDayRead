//
//  ClassifyDetailViewController.m
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ClassifyDetailViewController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"
#import "SingleList.h"


@interface ClassifyDetailViewController ()

@end

@implementation ClassifyDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = self.textString;
    SingleList *list = [SingleList shareInstance];
    list.type = self.textString;
   
        self.navigationController.navigationBar.translucent = NO;
    
    NSArray *titleArray = @[@"热门",@"新书",@"好评",@"完结"];
    NSArray *vcsArray = @[@"HotTableViewController",@"NewBookTableViewController",@"ReputablyViewController",@"BurglarViewController"];
    NSArray *colorArray = @[[UIColor blackColor],[UIColor grayColor],[UIColor orangeColor],[UIColor whiteColor]];

    NinaPagerView *ninaPageView = [[NinaPagerView alloc] initWithNinaPagerStyle:NinaPagerStyleBottomLine WithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    [self.view addSubview:ninaPageView];
    ninaPageView.pushEnabled = YES;
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
