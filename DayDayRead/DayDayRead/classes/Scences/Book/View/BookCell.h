//
//  BookCell.h
//  DayDayRead
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
@interface BookCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *BackGrandView;


@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@property (nonatomic, strong) Book *book;



@end
