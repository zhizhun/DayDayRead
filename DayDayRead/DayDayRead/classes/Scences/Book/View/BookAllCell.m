//
//  BookAllCell.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookAllCell.h"

@implementation BookAllCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

// 布局
- (void)initLayout {
    
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.layer.borderWidth = 1;
    self.label.layer.cornerRadius = 5;
    self.label.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.contentView addSubview:self.label];
}

@end
