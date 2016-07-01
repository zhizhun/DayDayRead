//
//  BookReViewCell.h
//  TTZS
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BookReviewOne;
@interface BookReViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *BackgrangView;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *oneTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *twoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@property (nonatomic, strong) BookReviewOne *bookReviewOne;






@end
