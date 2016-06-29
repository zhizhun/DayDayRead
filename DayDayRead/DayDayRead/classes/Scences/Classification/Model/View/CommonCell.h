//
//  CommonCell.h
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"
@interface CommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorCateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortIntroLabel;
@property (weak, nonatomic) IBOutlet UILabel *latelyFollowerLabel;

@property (weak, nonatomic) IBOutlet UILabel *retentionRatioLabel;

@property (nonatomic, strong)CommonModel *commonModel;

@end
