//
//  BookAllViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookAllViewController.h"
#import <NinaPagerView.h>
#import "NetWorkRequestManager.h"
#import "BookViewController.h"
#import "SingletonBook.h"
@interface BookAllViewController ()
@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) UIButton *button;


@end

@implementation BookAllViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    }

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    if (self.button.titleLabel.text == nil) {
        [button setTitle:@"筛选书单"forState:UIControlStateNormal];
    }
    
    button.tintColor = [UIColor blackColor];
    
    [button addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = button;
    self.button = button;
    NSArray *titleArray = @[@"本周最热",@"最新发布",@"最多收藏"];
    NSArray *vcsArray = @[@"BookOneViewController",@"BookTwoViewController",@"BookThrViewController"];
    
    NSArray *colorArray = @[
                            [UIColor brownColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor redColor], /**< 下划线颜色 Underline Color   **/
                            ];
    NinaPagerView *pagerView = [[NinaPagerView alloc] initWithNinaPagerStyle:NinaPagerStyleBottomLine WithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    [self.view addSubview:pagerView];
    pagerView.pushEnabled = YES;
    
    
    
}




#pragma mark -- YSLContainerViewControllerDelegate
- (void)hotRootViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
   
    [controller viewWillAppear:YES];
}

    


- (void)Action {
    __weak typeof(self)weakSelf = self;
    BookViewController *bookVC = [[BookViewController alloc] init];
    
    bookVC.block = ^void(NSString *textString) {
      
        
        [weakSelf.button setTitle:textString forState:UIControlStateNormal];
        
        
        [SingletonBook shareHandle].str = textString;
        
    };
  
    [self.navigationController pushViewController:bookVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
