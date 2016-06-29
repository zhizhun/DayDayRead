//
//  HotViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "HotViewController.h"
#import "URL.h"
#import <NinaPagerView.h>
#import "SingletonList.h"
@interface HotViewController ()

@property (nonatomic, strong) NSMutableArray *allHotArray;


@end

@implementation HotViewController

- (instancetype)init {
    
    if (self = [super init]) {
        
        SingletonList *list = [SingletonList shareHandle];
        
        list.array = @[HOT_WEEK_URL, HOT_MOUTH_URL, HOT_ALL_URL];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"周榜",@"月榜",@"总榜"];
    NSArray *vcsArray = @[@"OneViewController",@"TwoViewController",@"ThrViewController"];
    
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


@end
