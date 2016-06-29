//
//  HotCell.h
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hot.h"
@interface HotCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BackgrandView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TwoLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortIntroLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;

@property (nonatomic, strong) Hot *hot;



@end
