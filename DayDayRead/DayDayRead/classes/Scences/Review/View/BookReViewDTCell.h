//
//  BookReViewDTCell.h
//  TTZS
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookReviewThr.h"
@interface BookReViewDTCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *BackGrandView;

@property (weak, nonatomic) IBOutlet UIImageView *deImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *autorLabel;

@property (weak, nonatomic) IBOutlet UILabel *floorLabel;

@property (nonatomic, strong) BookReviewThr *thr;



@end
