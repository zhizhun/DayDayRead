//
//  Dynamic.h
//  项目
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dynamic : NSObject


//包含 title  content commented retweeted created
//包含avatar  nickname lv
@property (nonatomic,strong)NSDictionary *from;
//包含 content title
@property (nonatomic,strong)NSDictionary *refTweet;
//评论人数
@property (nonatomic, strong)NSString *commented;
//转发
@property (nonatomic, strong)NSString *retweeted;
//创建时间
@property (nonatomic, strong)NSString *created;
//现在的时间
@property (nonatomic, strong)NSString *hotAt;
@end
