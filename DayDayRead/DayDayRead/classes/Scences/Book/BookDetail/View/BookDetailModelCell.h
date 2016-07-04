//
//  BookDetailModelCell.h
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"
@interface BookDetailModelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BackgrandView;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (nonatomic, strong) BookDetailModel *detail;




@end
