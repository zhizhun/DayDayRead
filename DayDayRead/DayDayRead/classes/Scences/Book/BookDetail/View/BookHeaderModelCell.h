//
//  BookHeaderModelCell.h
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookHeaderModel.h"
@interface BookHeaderModelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BackGrandView;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoAuthorLabel;

@property (nonatomic, strong) BookHeaderModel *header;


@end
