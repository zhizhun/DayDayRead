//
//  SingleList.h
//  项目
//
//  Created by lanou3g on 16/6/26.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleList : NSObject

@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *gender;

//单例
+ (instancetype)shareInstance;
@end
