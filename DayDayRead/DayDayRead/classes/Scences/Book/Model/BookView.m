//
//  BookView.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookView.h"

@implementation BookView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    
    //样式
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    //大小
    self.myFlowLayout.itemSize = CGSizeMake((self.frame.size.width-50)/4, 30);
    
    //内边距
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //边框
   
    //头视图尺寸
    self.myFlowLayout.headerReferenceSize = CGSizeMake(20, 20);
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:self.myFlowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
}

@end
