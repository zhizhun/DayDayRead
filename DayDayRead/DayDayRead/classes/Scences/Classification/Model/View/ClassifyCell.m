//
//  ClassifyCell.m
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ClassifyCell.h"

@implementation ClassifyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self addsubViews];
        self.restorationIdentifier = @"cell";
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        
        CGFloat borderWidth = 1.0f;
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
       
        bgView.layer.borderColor = [UIColor clearColor].CGColor;
        bgView.layer.borderWidth = borderWidth;
        self.selectedBackgroundView = bgView;
        
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        
        UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
       
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.5f].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        [self.contentView addSubview:myContentView];
        
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
      
        [myContentView addSubview:self.nameLabel];

    }
    return self;
}


- (void)addsubViews {
//    self.nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
//    self.nameLabel.font = [UIFont systemFontOfSize:20];
//    self.nameLabel.textAlignment = NSTextAlignmentCenter;
////    self.nameLabel.backgroundColor = [UIColor yellowColor];
//    [myContentView addSubview:self.nameLabel];
//    
}

@end
