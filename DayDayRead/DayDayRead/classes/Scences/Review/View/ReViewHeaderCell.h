//
//  ReViewHeaderCell.h
//  TTZS
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookReviewHeader.h"
@interface ReViewHeaderCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *BackGrandView;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;

@property (weak, nonatomic) IBOutlet UILabel *oneAutor;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;

@property (weak, nonatomic) IBOutlet UILabel *twoTltle;

@property (weak, nonatomic) IBOutlet UILabel *twoAuthou;

@property (nonatomic, strong) BookReviewHeader *header;


@end
