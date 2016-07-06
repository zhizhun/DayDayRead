//
//  RunViewCell.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/25.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bookDetail.h"
@interface RunViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;


@property (weak, nonatomic) IBOutlet UILabel *authorLabel;


@property (nonatomic, strong) bookDetail *book;


@end
