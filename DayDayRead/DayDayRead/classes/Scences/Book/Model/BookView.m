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
    self.myFlowLayout.itemSize = CGSizeMake((self.frame.size.width-50)/4, 25);
    //内边距
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //边框
   
    //头视图尺寸
    self.myFlowLayout.headerReferenceSize = CGSizeMake(0, 20);
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.myFlowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
}

@end
