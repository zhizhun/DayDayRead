//
//  User.h
//  豆瓣
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject



// 用户名
@property (nonatomic, strong) NSString *userName;

// 密码
@property (nonatomic, strong) NSString *password;

// 头像
@property (nonatomic, strong) NSString *avatar;

// ID
@property (nonatomic, strong) NSString *userId;

// 是否登录
@property (nonatomic, assign) BOOL isLogin;

// 头像的url字符串
@property (nonatomic, strong) NSString *imageUrl;


@end
