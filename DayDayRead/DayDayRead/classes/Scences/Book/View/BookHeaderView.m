//
//  BookHeaderView.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookHeaderView.h"

@implementation BookHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.label];
}


@end
