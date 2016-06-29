//
//  DetailViewCell.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/29.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail.h"
@interface DetailViewCell : UITableViewCell

@property (nonatomic,strong)Detail *detail;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;


@end
