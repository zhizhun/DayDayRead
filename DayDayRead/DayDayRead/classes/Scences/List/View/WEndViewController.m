//
//  WEndViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "WEndViewController.h"
#import "URL.h"
#import <NinaPagerView.h>
#import "SingletonList.h"
@interface WEndViewController ()

@end

@implementation WEndViewController
- (instancetype)init {
    
    if (self = [super init]) {
        
        SingletonList *list = [SingletonList shareHandle];
        
        list.array = @[WEND_WEEK_URL, WEND_MOUTH_URL, WEND_ALL_URL];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"追书完结榜Top100(女生)";
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
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}



@end
