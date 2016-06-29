//
//  HeadReusableView.m
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "HeadReusableView.h"

@implementation HeadReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 添加子视图
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 60)];
    //    self.headerLabel.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.headerLabel];
}

@end
