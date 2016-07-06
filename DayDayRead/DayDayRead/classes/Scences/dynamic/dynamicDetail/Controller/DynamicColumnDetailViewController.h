//
//  DynamicColumnDetailViewController.h
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicDetail.h"
#import "Dynamic.h"

@interface DynamicColumnDetailViewController : UIViewController
@property (nonatomic,strong)Dynamic *dynamic;
@property (nonatomic,strong)DynamicDetail*dynamicDetail;
@end
